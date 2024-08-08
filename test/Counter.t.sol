// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter.sol";

contract DAOVotingTest is Test {
    DAOVoting public daoVoting;
    address public owner;
    address public member1;
    address public member2;

    function setUp() public {
        owner = address(this);
        member1 = address(0x1);
        member2 = address(0x2);
        daoVoting = new DAOVoting();
    }

    function testAddMember() public {
        daoVoting.addMember(member1);
        assertTrue(daoVoting.members(member1));
    }

    function testRemoveMember() public {
        daoVoting.addMember(member1);
        daoVoting.removeMember(member1);
        assertFalse(daoVoting.members(member1));
    }

    function testCreateProposal() public {
        daoVoting.createProposal("Test Proposal", 1 days);
        (string memory description,,,) = daoVoting.getProposal(1);
        assertEq(description, "Test Proposal");
    }

    function testVote() public {
        daoVoting.addMember(member1);
        daoVoting.createProposal("Test Proposal", 1 days);

        vm.prank(member1);
        daoVoting.vote(1);

        (, uint256 voteCount,,) = daoVoting.getProposal(1);
        assertEq(voteCount, 1);
    }

    function testExecuteProposal() public {
        daoVoting.createProposal("Test Proposal", 1 days);

        vm.warp(block.timestamp + 1 days + 1);

        daoVoting.executeProposal(1);

        (,,, bool executed) = daoVoting.getProposal(1);
        assertTrue(executed);
    }

    function testFailVoteAfterEndTime() public {
        daoVoting.addMember(member1);
        daoVoting.createProposal("Test Proposal", 1 days);

        vm.warp(block.timestamp + 1 days + 1);

        vm.prank(member1);
        daoVoting.vote(1);
    }

    function testFailDoubleVote() public {
        daoVoting.addMember(member1);
        daoVoting.createProposal("Test Proposal", 1 days);

        vm.startPrank(member1);
        daoVoting.vote(1);
        daoVoting.vote(1);
        vm.stopPrank();
    }
}
