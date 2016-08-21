using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

using Toybox.Sensor as Snsr;
using Toybox.Time as Time;

//! Class that represents the main Squash App
//! View
class SquashView extends Ui.View {

	//! Value of current heart rate read from sensor
	hidden var heartRate;
	//! Object that contains the data that will
	//! be displayed on screen
	hidden var dataTracker;

	//! Constructor
	//! @param dataTracker Shared objtect that contains 
	//! 	  the data that will be displayed on screen
    function initialize(dataTracker) {
        View.initialize();
        self.dataTracker = dataTracker;
        heartRate = 0;
        
        Snsr.setEnabledSensors( [Snsr.SENSOR_HEARTRATE] );
        Snsr.enableSensorEvents( method(:onSnsr) );
    }

    //! Load resources
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
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
		if (dataTracker.getSession().isRecording()) {
	        dataTracker.update();
	    }
        var time = dataTracker.getSession().getElapsedTime();
        dc.drawText(35, 43, Gfx.FONT_SMALL, dataTracker.getPlayer1Score(), Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(106, 43, Gfx.FONT_SMALL, dataTracker.getPlayer2Score(), Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(35, 98, Gfx.FONT_SMALL, dataTracker.getNumberOfSteps(), Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(106, 98, Gfx.FONT_SMALL, heartRate, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(30, 143, Gfx.FONT_SMALL, time, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(106, 143, Gfx.FONT_SMALL, dataTracker.getNumberOfCalories(), Gfx.TEXT_JUSTIFY_CENTER);
        
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }
    
    //! Function called to read heart rate sensor value
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
