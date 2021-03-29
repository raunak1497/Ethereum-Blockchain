var cokeVotesText = document.getElementById('cokeVotes');
var pepsiVotesText = document.getElementById('pepsiVotes');
var totalVotesP = document.getElementById('numVotesP');
var winnerP = document.getElementById('winnerP');
var selectionDiv = document.getElementById('selectionDiv');

var totalVotes = 0;
var cokeVotes = 0;
var pepsiVotes = 0;
var voted = false;

function castVote(candidateIndex){
    if(voted){
        alert('You have already voted');
        return;
    }
    voted=true;
    if(candidateIndex === 0 ){
        cokeVotes +=1;
        cokeVotesText.innerHTML = cokeVotes.toString();
    } else{
        pepsiVotes +=1;
        pepsiVotesText.innerHTML = pepsiVotes.toString();
    }
    totalVotes+=1;
    totalVotesP.innerHTML = 'Total turnout ' + totalVotes.toString();
}

function announceWinner() {
    var winner = ' ';
    if(cokeVotes>pepsiVotes){
        winner = 'Coke';
    }
    else{
        winner = 'Pepsi ';
    }
    winnerP.innerHTML = 'The Winner is ' + winner;
    winnerP.style.display = 'block';
    for(var i=0;i<2;i++)
    {
       selectionDiv.childNodes[i].disabled = true; 
    }
}





