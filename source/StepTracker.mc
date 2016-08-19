using Toybox.ActivityMonitor as Act;

class StepTracker {
	hidden var numberOfSteps;
	hidden var numberOfCalories;
	hidden var initialSteps;
	hidden var initialCalories;
	hidden var activityInfo;
	
	function initialize() {
		restart();
	}
	
	function restart() {
		numberOfSteps = 0;
		numberOfCalories = 0;
        activityInfo = Act.getInfo();
        initialSteps = activityInfo.steps;
        initialCalories = activityInfo.calories;
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
}