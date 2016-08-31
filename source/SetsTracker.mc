//! Class used to track the score of previous
//! sets of the game
class SetsTracker {
	//! Total number of points for one set
	hidden const MAX_SCORE = 11;
	//! Representation of Player 1
	const PLAYER_1 = 0;
	//! Representation of Player 2
	const PLAYER_2 = 1;
	//! Maximum amount of sets for a game
	const TOTAL_SETS = 5;
	//! Score of all sets of a game
	hidden var sets;
	//! Total game score (number of sets each player won)
	hidden var gameScore;
	//! Current set that is being played
	hidden var currentSet;
	
	function initialize() {
		currentSet = 0;
		sets = new [TOTAL_SETS];
		sets[currentSet] = [0, 0];
		gameScore = [0, 0];
	}
	
	//! Increases the score for a player
	//! @param player PLAYER_1 or PLAYER_2
	function increaseScore(player) {
		// Assert that player is 0 or 1.
		var won = didPlayerWon(player);
		if (!isGameOver()) {
			sets[currentSet][player]++;
			if (won) {
				updateGameScores(player);
			}
		}
		return won;
	}
	
	//! Private method that increments the total score
	//! for the given player and starts a new set if
	//! the game is not over
	//! @param player  PLAYER_1 or PLAYER_2
	hidden function updateGameScores(player){
		gameScore[player]++;
		if (!isGameOver()) {
			currentSet++;
			sets[currentSet] = [0, 0];
		}
	}
	
	//! Returns true is the given player won the current set
	//! @param player  PLAYER_1 or PLAYER_2
	function didPlayerWon(player) {
		return ((sets[currentSet][player] >= (MAX_SCORE - 1)) &&
				(sets[currentSet][player] - sets[currentSet][1 - player] > 1));
	}
	
	//! Get all sets
	//! @return all sets of the game
	function getSets(){
		return sets;
	}
	
	//! Get the current set score of the given player
	//! @param player  PLAYER_1 or PLAYER_2
	//! @return player score
	function getPlayerScore(player){
		return sets[currentSet][player];
	}
	
	//! Get the score of the game for each player
	//! @return an array containing the total score
	//!  of each player
	function getGameScore(){
		return gameScore;
	}
	
	//! Returns true if the game is over
	function isGameOver(){
		var setDifference = (gameScore[PLAYER_1] - gameScore[PLAYER_2]).abs();
		return ((currentSet == (TOTAL_SETS - 1)) || 
				// Someone is winning and the remaining sets cannot make the loser win
				((setDifference > 0) &&
				((TOTAL_SETS - 1) - currentSet) < setDifference));
	}
	
	//! Resets the counters of the current set for both players.
	function resetCurrentSet(){
		sets[currentSet] = [0, 0];
	}
	
}