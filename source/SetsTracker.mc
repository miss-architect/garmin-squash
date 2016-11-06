//! Class used to track the score of previous
//! sets of the game
class SetsTracker {
    //! Representation of Player 1
    const PLAYER_1 = 0;
    //! Representation of Player 2
    const PLAYER_2 = 1;
    //! Score of all sets of a game
    hidden var sets;
    //! Total game score (number of sets each player won)
    hidden var gameScore;
    //! Current set that is being played
    hidden var currentSet;
    //! Contains the configutation of the game
    hidden var gameConfiguration;

    function initialize() {
        gameConfiguration = GameConfiguration.getInstance();
        currentSet = 0;
        sets = new [gameConfiguration.getTotalSets()];
        sets[currentSet] = [0, 0];
        gameScore = [0, 0];
    }

    //! Increases the score for a player
    //! @param player PLAYER_1 or PLAYER_2
    function increaseScore(player) {
        // Assert that player is 0 or 1.
        var won = false;
        if (!isGameOver()) {
            sets[currentSet][player]++;
            if (didPlayerWin(player)) {
                updateGameScores(player);
                return true;
            }
        }
        return false;
    }

    //! Initializes the counter for a new set.
    function startNewSet(){
        if (!isGameOver()) {
            currentSet++;
            sets[currentSet] = [0, 0];
        }
    }

    //! Private method that increments the total score
    //! for the given player and starts a new set if
    //! the game is not over
    //! @param player  PLAYER_1 or PLAYER_2
    hidden function updateGameScores(player){
        gameScore[player]++;
    }

    //! Returns true is the given player won the current set
    //! @param player  PLAYER_1 or PLAYER_2
    function didPlayerWin(player) {
        return ((sets[currentSet][player] >= gameConfiguration.getMaxScore()) &&
                (sets[currentSet][player] - sets[currentSet][1 - player] > 1));
    }

    //! Returns if anyPlayerWon the current set
    hidden function anyPlayerWon() {
        return (didPlayerWin(PLAYER_1) || didPlayerWin(PLAYER_2));
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

    //! Returns true if it's the current set is the last one
    hidden function isTheLastSet() {
        return (currentSet == (gameConfiguration.getTotalSets() - 1));
    }

    //! Returns true if the player losing the match cannot
    //! win with the remaining sets
    hidden function theLoserCannotWin() {
        var setDifference = (gameScore[PLAYER_1] - gameScore[PLAYER_2]).abs();
        // Someone is winning and the remaining sets cannot make the loser win
        return  ((setDifference > 0) &&
                ((gameConfiguration.getTotalSets() - 1) - currentSet) < setDifference);
    }

    //! Returns true if the game is over
    function isGameOver(){
        return (anyPlayerWon() && (isTheLastSet() || theLoserCannotWin()));
    }

    //! Resets the counters of the current set for both players.
    function resetCurrentSet(){
        sets[currentSet] = [0, 0];
    }
}