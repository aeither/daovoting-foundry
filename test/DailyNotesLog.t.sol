// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/DailyNotesLog.sol";

contract DailyNotesLogTest is Test {
    DailyNotesLog public notesLog;
    address public user1;
    address public user2;

    function setUp() public {
        notesLog = new DailyNotesLog();
        user1 = address(0x1);
        user2 = address(0x2);
    }

    function testTwoPeopleCanAddNotes() public {
        vm.prank(user1);
        notesLog.addNote("Note from user1");

        vm.prank(user2);
        notesLog.addNote("Note from user2");

        DailyNotesLog.Note[] memory allNotes = notesLog.getAllNotes();
        assertEq(allNotes.length, 2);
        assertEq(allNotes[0].author, user1);
        assertEq(allNotes[0].content, "Note from user1");
        assertEq(allNotes[1].author, user2);
        assertEq(allNotes[1].content, "Note from user2");
    }

    function testAddThreeNotesAndCheckGetAllNotes() public {
        notesLog.addNote("First note");
        notesLog.addNote("Second note");
        notesLog.addNote("Third note");

        DailyNotesLog.Note[] memory allNotes = notesLog.getAllNotes();
        assertEq(allNotes.length, 3);
        assertEq(allNotes[0].content, "First note");
        assertEq(allNotes[1].content, "Second note");
        assertEq(allNotes[2].content, "Third note");
        assertEq(notesLog.noteCount(), 3);
    }

    function testResetAllNotesAndAddAgain() public {
        notesLog.addNote("Initial note");
        assertEq(notesLog.noteCount(), 1);

        notesLog.resetAllNotes();
        assertEq(notesLog.noteCount(), 0);

        DailyNotesLog.Note[] memory emptyNotes = notesLog.getAllNotes();
        assertEq(emptyNotes.length, 0);

        notesLog.addNote("New note after reset");
        DailyNotesLog.Note[] memory newNotes = notesLog.getAllNotes();
        assertEq(newNotes.length, 1);
        assertEq(newNotes[0].content, "New note after reset");
        assertEq(notesLog.noteCount(), 1);
    }
}
