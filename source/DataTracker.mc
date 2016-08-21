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
	//! Score of player 1
	hidden var player1Score;
	//! Score of player 2
	hidden var player2Score;
	//! Session used to record the activity
	hidden var session;
	
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
       	player1Score = 0;
		player2Score = 0;
		if (session != null && session.isRecording()) {
			session.stop();
		}
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
		return player1Score;
	}
	
	//! Returns the score of player 2
	function getPlayer2Score() {
		return player2Score;
	}
	
	//! Increments by 1 the score of player 1
	function incrementPlayer1Score() {
		player1Score++;
	}
	
	//! Increments by 1 the score of player 2
	function incrementPlayer2Score() {
		player2Score++;
	}
	
	//! Resets players' score counters
	function reset() {
		player1Score = 0;
		player2Score = 0;
	}
	
	//! Returns the session that records the activity
	function getSession() {
		return session;
	}
}