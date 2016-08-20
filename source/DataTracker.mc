using Toybox.ActivityMonitor as Act;

class DataTracker {
	hidden var numberOfSteps;
	hidden var numberOfCalories;
	hidden var initialSteps;
	hidden var initialCalories;
	hidden var activityInfo;
	hidden var player1Score;
	hidden var player2Score;
	hidden var session;
	
	function initialize() {
		session = new Session();
		restart();
	}
	
	function restart() {
		numberOfSteps = 0;
		numberOfCalories = 0;
        activityInfo = Act.getInfo();
        initialSteps = activityInfo.steps;
        initialCalories = activityInfo.calories;
       	player1Score = 0;
		player2Score = 0;
		if (session != null && session.isRecording()) {
			session.stop();
		}
	}
	
	function update() {
		activityInfo = Act.getInfo();
        numberOfSteps = activityInfo.steps - initialSteps;
        numberOfCalories = activityInfo.calories - initialCalories;
        
	}
	
	function getNumberOfSteps() {
		return numberOfSteps;
	}
	
	function getNumberOfCalories(){
		return numberOfCalories;
	}
	
	function getPlayer1Score() {
		return player1Score;
	}
	
	function getPlayer2Score() {
		return player2Score;
	}
	
	function incrementPlayer1Score() {
		player1Score++;
	}
	
	function incrementPlayer2Score() {
		player2Score++;
	}
	
	function reset() {
		player1Score = 0;
		player2Score = 0;
	}
	
	function getSession() {
		return session;
	}
}