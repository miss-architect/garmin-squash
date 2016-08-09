using Toybox.ActivityMonitor as Act;

class StepTracker {
	hidden var numberOfSteps;
	hidden var initialSteps;
	hidden var activityInfo;
	
	function initialize() {
		restart();
	}
	
	function restart() {
		numberOfSteps = 0;
        activityInfo = Act.getInfo();
        initialSteps = activityInfo.steps;
	}
	
	function update() {
		activityInfo = Act.getInfo();
        numberOfSteps = activityInfo.steps - initialSteps;
	}
	
	function getNumberOfSteps() {
		return numberOfSteps;
	}

}