pragma solidity ^0.4.0;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    struct voter{
      bool casted;
      uint to_candidate ;
    }
    // Store accounts that have voted
    mapping(address => voter) public voters;
    // Store Candidates
    // Fetch Candidate
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );
    event change_votedEvent (
        uint indexed _candidateId
    );

    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate (string _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender].casted);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);



        // record that voter has voted
        voters[msg.sender] = voter(true,_candidateId);


        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }

     function change_vote(uint _candidateId) public {
        require(voters[msg.sender].casted);
        require(_candidateId > 0 && _candidateId <= candidatesCount);
        candidates[voters[msg.sender].to_candidate].voteCount--;
        voters[msg.sender].to_candidate = _candidateId;
        candidates[_candidateId].voteCount++;
        emit votedEvent(_candidateId);
    }
}
