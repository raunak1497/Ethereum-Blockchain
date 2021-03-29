pragma solidity ^0.7.4;

contract SimpleVoting {
    
    struct candidate{
        bytes32 name;
        uint NoOfVotes;
    }
    
    struct voter {
        bool voted;
        uint vote;
    }
    
    candidate[] public candidates;
    mapping(address=>voter) public votes;
    
    address chairperson;
    
    constructor() public {
        chairperson=msg.sender;
        
        candidates.push(candidate({
            name : 'Coke',
            NoOfVotes : 0 
        }));
        candidates.push(candidate({
            name : 'Pepsi',
            NoOfVotes : 0
        }));
        
    }
    
    //function to cast vote to a candidate
    function castVote(uint candidateIndex) public{
        address sender = msg.sender;
        require(!votes[sender].voted,'The voter has already voted');
        candidates[candidateIndex].NoOfVotes += 1;
        votes[sender].voted=true;
        votes[sender].vote=candidateIndex;
    }
    
    //function to get who voted for whom
    function getVote(uint candidateIndex) public view returns(uint) {
        return candidates[candidateIndex].NoOfVotes;
    }
    
    //declare winner
    function getWinner() public view returns(bytes32 winner) {
        uint maxNoOfVotes;
        uint length =  candidates.length;
        for(uint i=0;i<length;i++){
            if(candidates[i].NoOfVotes>maxNoOfVotes)
            {
                maxNoOfVotes=candidates[i].NoOfVotes;
                winner=candidates[i].name;
            }
        }
    }
}