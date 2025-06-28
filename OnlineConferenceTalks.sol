// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract OnlineConferenceTalks {
    struct Conference {
        string name;
        uint startDate;
        uint endDate;
        string platform;
        bool isActive;
    }

    struct Talk {
        string title;
        string speaker;
        uint startTime;
        uint endTime;
        string description;
    }

    mapping(uint => Conference) public conferences;
    mapping(uint => Talk[]) public conferenceTalks;
    uint public conferenceCount;

    function addConference(string memory name, uint startDate, uint endDate, string memory platform) public {
        conferenceCount++;
        conferences[conferenceCount] = Conference({
            name: name,
            startDate: startDate,
            endDate: endDate,
            platform: platform,
            isActive: true
        });
    }

    function addTalk(uint conferenceId, string memory title, string memory speaker, uint startTime, uint endTime, string memory description) public {
        require(conferences[conferenceId].isActive, "Conference is not active.");
        conferenceTalks[conferenceId].push(Talk({
            title: title,
            speaker: speaker,
            startTime: startTime,
            endTime: endTime,
            description: description
        }));
    }

    function getConference(uint conferenceId) public view returns (string memory, uint, uint, string memory, bool) {
        Conference memory conference = conferences[conferenceId];
        return (conference.name, conference.startDate, conference.endDate, conference.platform, conference.isActive);
    }

    function getConferenceTalks(uint conferenceId) public view returns (Talk[] memory) {
        return conferenceTalks[conferenceId];
    }
}