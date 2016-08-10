using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

using Toybox.Sensor as Snsr;

var action_string;

function setActionString(new_string)
{
    action_string = new_string;
    Ui.requestUpdate();
}

class SquashView extends Ui.View {
	hidden var activityInfo;
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
        //player1Score.draw();
        //player2Score.draw();
        stepTracker.update();
        
        dc.drawText(35, 43, Gfx.FONT_SMALL, scores.player1Score, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(106, 43, Gfx.FONT_SMALL, scores.player2Score, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(35, 98, Gfx.FONT_SMALL, stepTracker.getNumberOfSteps(), Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(106, 98, Gfx.FONT_SMALL, heartRate, Gfx.TEXT_JUSTIFY_CENTER);
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
