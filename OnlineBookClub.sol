// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract OnlineBookClub {
    struct BookClub {
        string name;
        string description;
        address moderator;
        bool isActive;
    }

    struct Book {
        string title;
        string author;
        uint isbn;
        string summary;
    }

    mapping(uint => BookClub) public bookClubs;
    mapping(uint => Book[]) public clubBooks;
    uint public bookClubCount;

    function addBookClub(string memory name, string memory description) public {
        bookClubCount++;
        bookClubs[bookClubCount] = BookClub({
            name: name,
            description: description,
            moderator: msg.sender,
            isActive: true
        });
    }

    function addBook(uint clubId, string memory title, string memory author, uint isbn, string memory summary) public {
        require(bookClubs[clubId].moderator == msg.sender, "Not the moderator.");
        require(bookClubs[clubId].isActive, "Book club is not active.");
        clubBooks[clubId].push(Book({
            title: title,
            author: author,
            isbn: isbn,
            summary: summary
        }));
    }

    function getBookClub(uint clubId) public view returns (string memory, string memory, address, bool) {
        BookClub memory bookClub = bookClubs[clubId];
        return (bookClub.name, bookClub.description, bookClub.moderator, bookClub.isActive);
    }

    function getClubBooks(uint clubId) public view returns (Book[] memory) {
        return clubBooks[clubId];
    }
}