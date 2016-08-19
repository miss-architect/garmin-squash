using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

using Toybox.Sensor as Snsr;
using Toybox.Time as Time;

var action_string;

function setActionString(new_string)
{
    action_string = new_string;
    Ui.requestUpdate();
}

class SquashView extends Ui.View {
	hidden var stepTracker;
	hidden var heartRate;
	hidden var scores;

    function initialize(scores) {
        View.initialize();
        self.scores = scores;
        heartRate = 0;
        stepTracker = new StepTracker();
        
        Snsr.setEnabledSensors( [Snsr.SENSOR_HEARTRATE] );
        Snsr.enableSensorEvents( method(:onSnsr) );
    }

    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
        //player1Score.setConfiguration(dc, 0);
        //player2Score.setConfiguration(dc, (dc.getWidth() / 2));
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }
    
    //! Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        
        
        var time = "0:00:00";
        if (sessionStarted != null ) {
        	stepTracker.update();
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
        else {
        	// TODO: restart the step tracker when the session is created, not here.
        	stepTracker.restart();
        }
        dc.drawText(35, 43, Gfx.FONT_SMALL, scores.player1Score, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(106, 43, Gfx.FONT_SMALL, scores.player2Score, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(35, 98, Gfx.FONT_SMALL, stepTracker.getNumberOfSteps(), Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(106, 98, Gfx.FONT_SMALL, heartRate, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(30, 143, Gfx.FONT_SMALL, time, Gfx.TEXT_JUSTIFY_CENTER);
        
        dc.drawText(106, 143, Gfx.FONT_SMALL, stepTracker.getNumberOfCalories(), Gfx.TEXT_JUSTIFY_CENTER);
        
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }
    
    function onSnsr(sensor_info)
    {
        if( sensor_info.heartRate != null )
        {
        	heartRate = sensor_info.heartRate.toString();
        }
        else
        {
        	heartRate = "---";
        }
        Ui.requestUpdate();
    }

}
