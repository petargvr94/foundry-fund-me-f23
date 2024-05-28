// SPDX-License-Identifier: MIT

// 1. Deploy mocks when we are on a local anvil chain
// 2.Keep track of contract address accross different chains

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script{
    // If we are on local anvil, we deploy mocks
    // Otherwise, grab the existing address from the live network
    NetworkConfig public activeNetworkConfig;

    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    struct NetworkConfig {
        address priceFeed; // ETH/USED price feed address
    }

    constructor(){
        activeNetworkConfig = getOrCreateAnvilEthConfig();
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory){
        // price feed address
    }

    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory){
     // 1.Deploy the mocks
     // 2.Return the mock addresses
     if(activeNetworkConfig.priceFeed != address(0))
     {
        return activeNetworkConfig;
     }
     vm.startBroadcast();
     MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMALS,INITIAL_PRICE);
     vm.stopBroadcast();

     NetworkConfig memory anvilConfig = NetworkConfig({
        priceFeed: address(mockPriceFeed)
     });
     return anvilConfig;
    }

}