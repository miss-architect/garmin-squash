using Toybox.WatchUi as Ui;
using Toybox.Attention as Attention;
using Toybox.Time as Time;

var session = null;
var sessionStarted = null;

class SquashDelegate extends Ui.BehaviorDelegate {
	
	hidden var dataTracker;

    function initialize(dataTracker) {
        BehaviorDelegate.initialize();
        self.dataTracker = dataTracker;
    }

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
    
    function onReset() {
    	dataTracker.reset();
    }
    
    function onPlayer1(){
    	dataTracker.incrementPlayer1Score();
    }
    
    function onPlayer2(){
    	dataTracker.incrementPlayer2Score();
    }

}