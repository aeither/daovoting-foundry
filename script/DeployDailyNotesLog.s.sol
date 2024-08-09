// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/DailyNotesLog.sol";

contract DeployDailyNotesLog is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        DailyNotesLog dailyNotesLog = new DailyNotesLog();

        vm.stopBroadcast();
    }
}
