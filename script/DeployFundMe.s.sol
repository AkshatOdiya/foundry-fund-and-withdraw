// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";

import {HelperConfig} from "./HelperConfig.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        HelperConfig helperConfig = new HelperConfig();
        address priceFeed = helperConfig.ActiveNetworkConfig();
        vm.startBroadcast();
        FundMe fundme = new FundMe(priceFeed);
        //This statement is setting the pricefeed in the constructor in FundMe.sol
        vm.stopBroadcast();
        return fundme;
    }
}
