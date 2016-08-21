using Toybox.WatchUi as Ui;
using Toybox.Attention as Attention;
using Toybox.Time as Time;

//! Class that handles events coming from
//! the Squash View
class SquashDelegate extends Ui.BehaviorDelegate {
	
	//! Object that contains the data that will
	//! be displayed on screen
	hidden var dataTracker;

	//! Constructor
	//! @param dataTracker Shared objtect that contains 
	//! 	  the data that will be displayed on screen
    function initialize(dataTracker) {
        BehaviorDelegate.initialize();
        self.dataTracker = dataTracker;
    }

	//! Function called when the menu button is pressed
	//! In this view, it should start or stop recording
	//! the session
    function onMenu() {
    	if (dataTracker.getSession().isRecording()) {
    		dataTracker.getSession().stop();
    	}
    	else {
    		dataTracker.getSession().start();
    	}
		vibrate();
		Ui.requestUpdate();
        return true;
    }
    
    //! Performs a vibration. Used as feedback to the user
    //! for starting and stopping recording the session
    function vibrate() {
    	if (Attention has :vibrate) {
            var vibrateData = [
                    new Attention.VibeProfile(  25, 100 ),
                    new Attention.VibeProfile(  50, 100 ),
                    new Attention.VibeProfile(  75, 100 ),
                    new Attention.VibeProfile( 100, 100 ),
                    new Attention.VibeProfile(  75, 100 ),
                    new Attention.VibeProfile(  50, 100 ),
                    new Attention.VibeProfile(  25, 100 )
                  ];

            Attention.vibrate(vibrateData);
        }
    }
    
    //! Function called when the reset button of the UI is pressed.
    function onReset() {
    	dataTracker.reset();
    }
    
    //! Function called when the player 1 score button is pressed.
    function onPlayer1(){
    	dataTracker.incrementPlayer1Score();
    }
    
    //! Function called when the player 2 score button is pressed.
    function onPlayer2(){
    	dataTracker.incrementPlayer2Score();
    }

}