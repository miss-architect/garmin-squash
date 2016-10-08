using Toybox.ActivityMonitor as Act;

//! Class that holds the data that has to be
//! valculated and is displayed in the UI.
class DataTracker {
    //! Number of steps done during the activity
    hidden var numberOfSteps;
    //! Number of calories burned during the activity
    hidden var numberOfCalories;
    //! Number of steps done when the activity started
    hidden var initialSteps;
    //! Amount of calories burnt until the activity started
    hidden var initialCalories;
    //! Session used to record the activity
    hidden var session;
    //! Sets tracker
    hidden var setsTracker;

    //! Constructor
    function initialize() {
        session = new Session();
        restart();
    }

    //! Restarts all the data field to make it ready
    //! to record a new session
    function restart() {
        numberOfSteps = 0;
        numberOfCalories = 0;
        var activityInfo = Act.getInfo();
        initialSteps = activityInfo.steps;
        initialCalories = activityInfo.calories;
        if (session != null && session.isRecording()) {
            var gameScore = setsTracker.getGameScore();
            session.saveGameScore(gameScore[0], gameScore[1]);
            session.stop();
        }
        setsTracker = new SetsTracker();
    }

    //! Updates the calculated values taken from
    //! the activity info data
    function update() {
        var activityInfo = Act.getInfo();
        numberOfSteps = activityInfo.steps - initialSteps;
        numberOfCalories = activityInfo.calories - initialCalories;
        
    }

    //! Returns the number of steps done during the current activity
    function getNumberOfSteps() {
        return numberOfSteps;
    }

    //! Returns the number of calories burnt during the current activity
    function getNumberOfCalories(){
        return numberOfCalories;
    }

    //! Returns the score of player 1
    function getPlayer1Score() {
        return setsTracker.getPlayerScore(0);
    }

    //! Returns the score of player 2
    function getPlayer2Score() {
        return setsTracker.getPlayerScore(1);
    }

    //! Increments by 1 the score of player 1
    function incrementPlayer1Score() {
        var wonSet = setsTracker.increaseScore(0);

        if (wonSet) {
            session.recordSetScore(setsTracker.getPlayerScore(0), setsTracker.getPlayerScore(1));
            setsTracker.startNewSet();
        }
        return wonSet;
    }

    //! Increments by 1 the score of player 2
    function incrementPlayer2Score() {
        var wonSet = setsTracker.increaseScore(1);

        if (wonSet) {
            session.recordSetScore(setsTracker.getPlayerScore(0), setsTracker.getPlayerScore(1));
            setsTracker.startNewSet();
        }
        return wonSet;
    }

    //! Get the total game score for both players
    //! @return array of 2 elements containg the scores
    function getGameScore(){
        return setsTracker.getGameScore();
    }

    //! Returns true if the game is over
    function isGameOver(){
        return setsTracker.isGameOver();
    }

    //! Resets players' score counters
    function reset() {
        setsTracker.resetCurrentSet();
    }

    //! Returns the session that records the activity
    function getSession() {
        return session;
    }

}