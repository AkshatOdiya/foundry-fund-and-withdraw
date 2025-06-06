// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    uint256 number = 1;
    FundMe fundme;
    address USER = makeAddr("user");
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1 ether;

    function setUp() external {
        DeployFundMe deployfundme = new DeployFundMe();
        fundme = deployfundme.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testMinimumDollarIsFive() public view {
        assertEq(fundme.MINIMUM_USD(), 5e18);
    }

    function testOwner() public view {
        assertEq(fundme.getOwner(), msg.sender);
    }

    function testVersion() public view {
        assertEq(fundme.getVersion(), 4);
    }

    function testFundFailWithoutEnoughEth() public {
        vm.expectRevert();
        fundme.fund();
    }

    function testStorageVariable() public {
        fundme.fund{value: 10e18}();
        uint256 amount = fundme.getAddressToAmountFunded(address(this));
        assertEq(amount, 10e18);
        address funderAddress = fundme.getFunder(0);
        assertEq(funderAddress, address(this));
    }

    modifier funded() {
        vm.prank(USER);
        vm.deal(USER, 10e18);
        fundme.fund{value: 10e18}();
        _;
    }

    function testWithdrawNotOwner() public funded {
        vm.prank(USER);
        vm.expectRevert();
        fundme.cheaperWithdraw();
    }

    function testWithdrawSingleFunder() public funded {
        //three ponits to follow
        //Arrange
        uint256 startingOwnerBalance = fundme.getOwner().balance;
        uint256 startinfundmeBalance = address(fundme).balance;
        //Act
        vm.prank(fundme.getOwner());
        fundme.cheaperWithdraw();
        //Assert
        uint256 endingOwnerBalance = fundme.getOwner().balance;
        uint256 endingfundmeBalance = address(fundme).balance;
        assertEq(endingfundmeBalance, 0);
        assertEq(
            endingOwnerBalance,
            startinfundmeBalance + startingOwnerBalance
        );
    }

    function testWithdrawFromMultipleFunders() public funded {
        uint160 numberOfFunders = 9;
        uint160 startingIndex = 1;
        for (uint160 i = startingIndex; i <= numberOfFunders; i++) {
            hoax(address(i), 10e18); //hoax does the work of both vm.prank and vm.deal
            fundme.fund{value: 10e18}();
        }
        uint256 startingOwnerBalance = fundme.getOwner().balance;
        uint256 startinfundmeBalance = address(fundme).balance;
        //Act
        vm.startPrank(fundme.getOwner());
        fundme.cheaperWithdraw();
        vm.stopPrank();
        //Assert
        uint256 endingOwnerBalance = fundme.getOwner().balance;
        uint256 endingfundmeBalance = address(fundme).balance;
        assertEq(endingfundmeBalance, 0);
        assertEq(
            endingOwnerBalance,
            startinfundmeBalance + startingOwnerBalance
        );
    }
}
