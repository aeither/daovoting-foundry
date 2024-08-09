// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract DailyNotesLog {
    struct Note {
        address author;
        string content;
        uint256 timestamp;
    }

    Note[] public notes;
    uint256 public noteCount;

    event NoteAdded(address indexed author, string content, uint256 timestamp);
    event NotesReset();

    function addNote(string memory _content) public {
        Note memory newNote = Note({author: msg.sender, content: _content, timestamp: block.timestamp});

        notes.push(newNote);
        noteCount++;

        emit NoteAdded(msg.sender, _content, block.timestamp);
    }

    function getAllNotes() public view returns (Note[] memory) {
        return notes;
    }

    function resetAllNotes() public {
        delete notes;
        noteCount = 0;

        emit NotesReset();
    }
}
