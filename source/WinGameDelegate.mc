using Toybox.WatchUi as Ui;

//! Class that handles events coming from
//! the Squash View
class WinGameDelegate extends Ui.BehaviorDelegate {
	
	//! Object that contains the data that contains the session
	hidden var dataTracker;

	//! Constructor
	//! @param dataTracker Shared objtect that contains 
	//! 	  the data that will be displayed on screen
    function initialize(dataTracker) {
        BehaviorDelegate.initialize();
        self.dataTracker = dataTracker;
    }
    
    //! When back button is pressed we should stop the session
    //! because the game is over. The user can start a new
    //! game and session later.
    function onBack() {
    	dataTracker.restart();
    }
}