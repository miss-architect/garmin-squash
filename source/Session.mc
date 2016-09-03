using Toybox.ActivityRecording as Record;
using Toybox.FitContributor as Fit;

//! Class used to record an activity
class Session {

	//! Garmin session object
	hidden var session;
	//! Time when the session started
	hidden var sessionStarted;
	
	// Field ID from resources.
	hidden const PLAYER1_FIELD_ID = 0;
	hidden const PLAYER2_FIELD_ID = 1;
    hidden const PLAYER1_GAME_SCORE_FIELD_ID = 2;
	hidden const PLAYER2_GAME_SCORE_FIELD_ID = 3;
	hidden var player1ScoreField;
	hidden var player2ScoreField;
	hidden var player1GameScoreField;
	hidden var player2GameScoreField;
	
	//! Constructor
	function initialize() {
		session = null;
	}
	
	//! Start recording a new session
	//! If the session was already recording, nothing happens
	function start(){
	    if(Toybox has :ActivityRecording ) {
	    	if(!isRecording()) {
	       		session = Record.createSession({:name=>"Squash", 
	        									:sport=>Record.SPORT_TENNIS, 
	        									:subSport=>Record.SUB_SPORT_MATCH});
	        	setupFields();
	        	session.start();
	        	sessionStarted = Time.now();
	        	vibrate();
	        }
	    }
	}
	
	//! Stops the current session
	//! If the session was already stopped, nothing happens
	function stop() {
		if(isRecording()) {
            session.stop();
            session.save();
            sessionStarted = null;
            session = null;
        	vibrate();
        }
	}
	
	//! Returns true if the session is recording
	function isRecording() {
		return (session != null) && session.isRecording();
	}
	
	//! Returns a string containing the session's elapsed time
	function getElapsedTime(){
			var time = "0:00:00";
			if (isRecording()) {
			    var elapsedTime = 0;
	        	elapsedTime = Time.now().subtract(sessionStarted);
				var time_in_seconds = elapsedTime.value();
				var hrs = time_in_seconds / 3600;
				time_in_seconds -= (hrs * 3600);
				var min = time_in_seconds / 60;
				time_in_seconds -= (min * 60);
				time = Lang.format("$1$:$2$:$3$",
				[ hrs, min.format("%0.2d"), time_in_seconds.format("%0.2d") ]);
			}
			
			return time;
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
	
	// Initializes the new Namaste field in the activity file
	hidden function setupFields() {
	    // Create a new field in the session.
	    // Current namastes provides an file internal definition of the field
	    // Field id _must_ match the fitField id in resources or your data will not display!
	    // The field type specifies the kind of data we are going to store. For Record data this must be numeric, for others it can also be a string.
	    // The mesgType allows us to say what kind of FIT record we are writing.
	    //    FitContributor.MESG_TYPE_RECORD for graph information
	    //    FitContributor.MESG_TYPE_LAP for lap information
	    //    FitContributor.MESG_TYPE_SESSION` for summary information.
	    // Units provides a file internal units field.
	    player1ScoreField = session.createField("player1score", PLAYER1_FIELD_ID, FitContributor.DATA_TYPE_UINT8, { :mesgType=>Fit.MESG_TYPE_LAP });
		player1ScoreField.setData(0);
		player2ScoreField = session.createField("player2score", PLAYER2_FIELD_ID, FitContributor.DATA_TYPE_UINT8, { :mesgType=>Fit.MESG_TYPE_LAP });
		player2ScoreField.setData(0);
		player1GameScoreField = session.createField("player1GameScore", PLAYER1_GAME_SCORE_FIELD_ID, FitContributor.DATA_TYPE_UINT8, { :mesgType=>Fit.MESG_TYPE_SESSION });
		player1GameScoreField.setData(0);
		player2GameScoreField = session.createField("player2GameScore", PLAYER2_GAME_SCORE_FIELD_ID, FitContributor.DATA_TYPE_UINT8, { :mesgType=>Fit.MESG_TYPE_SESSION });
		player2GameScoreField.setData(0);
	}
	
	function recordSetScore(player1score, player2score) {
		System.println(player1score + " - " + player2score);
		player1ScoreField.setData(player1score);
		player2ScoreField.setData(player2score);
		session.addLap();
	}
	
	function saveGameScore(player1score, player2score) {
		player1GameScoreField.setData(player1score);
		player2GameScoreField.setData(player2score);	
	}
}