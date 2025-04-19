// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract VotingManagementSystem{
  address admin=msg.sender;
   address voter;
  mapping(address=>bool) public voters;
  constructor(){
        admin=msg.sender;
    }

     modifier adminOnly(address _admin){
        require (msg.sender == _admin,"You are not authorized to do this");
        _;
    }

  function registerVoter(address _voter) public {
    require (!voters[_voter],"This voter is already registered.");
      voters[_voter] = true;
  }

    struct Election{
      string name;
      string description;
      uint period;
    }

    Election public elec;
    function createElection(string memory _name, string memory _description, uint _period) public{
     elec= Election(_name, _description, _period);
    }

    function updateElection(string memory _name, string memory _description, uint _period) public{
      require(msg.sender == admin, "You are not allowed to do this");
        elec.name =_name;
        elec.description =_description;
        elec.period=_period;
    }

     enum ElectionLevel{National, State, Local}
     string electionLevel;
     function setLevel() public{
      electionLevel="National";
     } 
  
    struct Candidate{
      string name;
      uint id;
    }
    mapping(address => Candidate) public candidates;
    function addCandidate(string memory _name, uint _id) public{
    candidates[msg.sender]=Candidate(_name,_id);
    }

    function updateCandidate(string memory _name, uint _id) public{
      require(msg.sender == admin, "You are not allowed to do this");
      candidates[msg.sender]=Candidate(_name,_id);
    }

  function delCandidate(string memory _name, uint _id) public{
      require(msg.sender == admin, "You are not allowed to do this");
      candidates[msg.sender]=Candidate(_name,_id);
  }

    struct Vote{
      address voter;
      uint electionId;
      uint candidateId;
    }
    mapping(address=>uint) public votes;
    function castVote(uint _candidateId) public{
    require(votes[msg.sender]==0, "You are already voted");
        votes[msg.sender] =  _candidateId;
    }
     
     uint public totalVotes;
     function setTotalVotes(uint _totalVotes) public{
      totalVotes= _totalVotes;
     }
     function getTotalVotes() public view returns(uint){
      return totalVotes;
     }

     mapping(uint=>uint) public candidateVotes;
     function getVoteResults(uint candidateId) public view returns(uint){
      return candidateVotes[candidateId];
     }
    
}