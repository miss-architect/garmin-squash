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
	hidden var player1Score, player2Score;
	hidden var activityInfo;
	hidden var stepTracker;

    function initialize(player1Score, player2Score) {
        View.initialize();
        self.player1Score = player1Score;
        self.player2Score = player2Score;
        stepTracker = new StepTracker();
        
        Snsr.setEnabledSensors( [Snsr.SENSOR_HEARTRATE] );
        Snsr.enableSensorEvents( method(:onSnsr) );
    }

    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
        player1Score.setConfiguration(dc, 0);
        player2Score.setConfiguration(dc, (dc.getWidth() / 2));
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
        player1Score.draw();
        player2Score.draw();
        stepTracker.update();
        System.println(stepTracker.getNumberOfSteps()); 
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }
    
    function onSnsr(sensor_info)
    {
        /*var HR = sensor_info.heartRate;
        var bucket;
        if( sensor_info.heartRate != null )
        {
            string_HR = HR.toString() + "bpm";

			System.println(string_HR);
            //Add value to graph
            //HR_graph.addItem(HR);
        }
        else
        {
            string_HR = "---bpm";
        }*/
       
        System.println(sensor_info.heartRate);
        Ui.requestUpdate();
    }

}
