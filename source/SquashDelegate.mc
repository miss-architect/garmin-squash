using Toybox.WatchUi as Ui;
using Toybox.ActivityRecording as Record;
using Toybox.Attention as Attention;
using Toybox.Time as Time;

var session = null;
var sessionStarted = null;

class SquashDelegate extends Ui.BehaviorDelegate {

	hidden var player1Score, player2Score;
	hidden var scores;

    function initialize(scores) {
        BehaviorDelegate.initialize();
        self.scores = scores;
    }

    function onMenu() {
        if(Toybox has :ActivityRecording ) {
            if( ( session == null ) || ( session.isRecording() == false ) ) {
                session = Record.createSession({:name=>"Squash", 
                								:sport=>Record.SPORT_TENNIS, 
                								:subSport=>Record.SUB_SPORT_MATCH});
                session.start();
                sessionStarted = Time.now();
                vibrate();
                Ui.requestUpdate();
            }
            else if( ( session != null ) && session.isRecording() ) {
                session.stop();
                session.save();
                sessionStarted = null;
                vibrate();
                session = null;
                Ui.requestUpdate();
            }
        }
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
    	scores.reset();
    }
    
    function onPlayer1(){
    	scores.player1Score++;
    }
    
    function onPlayer2(){
    	scores.player2Score++;
    }

}