// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract OnlineConference {
    struct Conference {
        string name;
        uint startDate;
        uint endDate;
        string platform;
        bool isActive;
    }

    struct Session {
        string title;
        string speaker;
        uint startTime;
        uint endTime;
    }

    mapping(uint => Conference) public conferences;
    mapping(uint => Session[]) public conferenceSessions;
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

    function addSession(uint conferenceId, string memory title, string memory speaker, uint startTime, uint endTime) public {
        require(conferences[conferenceId].isActive, "Conference is not active.");
        conferenceSessions[conferenceId].push(Session({
            title: title,
            speaker: speaker,
            startTime: startTime,
            endTime: endTime
        }));
    }

    function getConference(uint conferenceId) public view returns (string memory, uint, uint, string memory, bool) {
        Conference memory conference = conferences[conferenceId];
        return (conference.name, conference.startDate, conference.endDate, conference.platform, conference.isActive);
    }

    function getConferenceSessions(uint conferenceId) public view returns (Session[] memory) {
        return conferenceSessions[conferenceId];
    }
}