using Toybox.ActivityRecording as Record;

class Session {

	hidden var session;
	hidden var sessionStarted;
	
	function initialize() {
		session = null;
	}
	
	function start(){
	    if(Toybox has :ActivityRecording ) {
	    	if(!isRecording()) {
	       		session = Record.createSession({:name=>"Squash", 
	        									:sport=>Record.SPORT_TENNIS, 
	        									:subSport=>Record.SUB_SPORT_MATCH});
	        	session.start();
	        	sessionStarted = Time.now();
	        }
	    }
	}
	
	function stop() {
		if(isRecording()) {
            session.stop();
            session.save();
            sessionStarted = null;
            session = null;
        }
	}

	function isRecording() {
		return (session != null) && session.isRecording();
	}
	
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
}