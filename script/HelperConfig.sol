// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "../forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

//This file is made to switch to whatevery network configuration we want to put our project on
//And this make it easier because we dont have to everytime put the prive feed manualy.
//Making these types of file can help to reduce our work, when big projects are concerned

contract HelperConfig is Script {
    NetworkConfig public ActiveNetworkConfig;

    struct NetworkConfig {
        address pricefeed;
    }

    uint8 constant DECIMAL = 8;
    int256 constant INITIAL_PRICE = 2000e8;

    constructor() {
        //ChainIB of ETH sepolia is 1115511, you can see on Chainlist by typing ethereum sepolia
        if (block.chainid == 11155111) {
            ActiveNetworkConfig = getSepoliaEthConfig();
        } else {
            ActiveNetworkConfig = getOrCreateAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        //we need to use memory keyword because this is a NetworkConfig is a special object

        NetworkConfig memory sepoliaConfig = NetworkConfig({pricefeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return sepoliaConfig;
    }

    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory) {
        //The contract might be reused (not redeployed) across multiple calls in the same script or session.
        //It’s a defensive pattern, to make it more robust
        if (ActiveNetworkConfig.pricefeed != address(0)) {
            return ActiveNetworkConfig;
        }
        //1. Deploy mock
        //2. Return mock address
        //we have to deploy our own pricefeed, we have to make new Contract

        vm.startBroadcast();
        MockV3Aggregator MockPriceFeed = new MockV3Aggregator(DECIMAL, INITIAL_PRICE);
        vm.stopBroadcast();
        NetworkConfig memory AnvilConfig = NetworkConfig({pricefeed: address(MockPriceFeed)});
        return AnvilConfig;
    }
}
