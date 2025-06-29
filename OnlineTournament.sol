// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract OnlineTournament {
    struct Tournament {
        string name;
        uint startDate;
        uint endDate;
        string game;
        bool isActive;
    }

    struct Participant {
        address participantAddress;
        string name;
        uint score;
    }

    mapping(uint => Tournament) public tournaments;
    mapping(uint => Participant[]) public tournamentParticipants;
    uint public tournamentCount;

    function addTournament(string memory name, uint startDate, uint endDate, string memory game) public {
        tournamentCount++;
        tournaments[tournamentCount] = Tournament({
            name: name,
            startDate: startDate,
            endDate: endDate,
            game: game,
            isActive: true
        });
    }

    function registerParticipant(uint tournamentId, string memory name) public {
        require(tournaments[tournamentId].isActive, "Tournament is not active.");
        tournamentParticipants[tournamentId].push(Participant({
            participantAddress: msg.sender,
            name: name,
            score: 0
        }));
    }

    function updateScore(uint tournamentId, address participantAddress, uint score) public {
        Participant[] storage participants = tournamentParticipants[tournamentId];
        for (uint i = 0; i < participants.length; i++) {
            if (participants[i].participantAddress == participantAddress) {
                participants[i].score = score;
                break;
            }
        }
    }

    function getTournament(uint tournamentId) public view returns (string memory, uint, uint, string memory, bool) {
        Tournament memory tournament = tournaments[tournamentId];
        return (tournament.name, tournament.startDate, tournament.endDate, tournament.game, tournament.isActive);
    }

    function getTournamentParticipants(uint tournamentId) public view returns (Participant[] memory) {
        return tournamentParticipants[tournamentId];
    }
}