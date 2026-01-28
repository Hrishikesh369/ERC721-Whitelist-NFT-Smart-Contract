//SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import {Script} from "forge-std/Script.sol";
import {Whitelist} from "../src/Whitelist.sol";
import {CryptoDevs} from "../src/CryptoDevs.sol";

contract DeployNft is Script {
    function run() external {
        vm.startBroadcast();
        Whitelist whitelist = new Whitelist();
        new CryptoDevs(address(whitelist));
        vm.stopBroadcast();
    }
}
