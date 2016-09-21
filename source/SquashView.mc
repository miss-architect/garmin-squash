using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

using Toybox.Sensor as Snsr;
using Toybox.Time as Time;
using Toybox.System as System;


//! Class that represents the main Squash App
//! View
class SquashView extends Ui.View {

    hidden const VERTICAL_SPACING = 2;
    hidden const EXTRA_VERTICAL_SPACING = 10;
    hidden const HORIZONTAL_SPACING = 6;

    //! Array of 2 buttons containing the player 1 and player 2
    //! buttons
    hidden var playerButtons;

    //! Value of current heart rate read from sensor
    hidden var heartRate;
    //! Object that contains the data that will
    //! be displayed on screen
    hidden var dataTracker;

    //! Vertical place in the screen where we start
    //! drawing. In round watches we should leave
    //! some initial vertical space.
    hidden var initialY;

    //! Constructor
    //! @param dataTracker Shared objtect that contains 
    //! the data that will be displayed on screen
    function initialize(dataTracker) {
        View.initialize();
        self.dataTracker = dataTracker;
        heartRate = 0;

        Snsr.setEnabledSensors( [Snsr.SENSOR_HEARTRATE] );
        Snsr.enableSensorEvents( method(:onSnsr) );
    }

    //! Load resources
    function onLayout(dc) {
        initialY = EXTRA_VERTICAL_SPACING;
        if (System.getDeviceSettings().screenShape == System.SCREEN_SHAPE_ROUND) {
            initialY += 10;
        }

        var heightButton = dc.getFontHeight(Gfx.FONT_TINY) + dc.getFontHeight(Gfx.FONT_NUMBER_MILD) + VERTICAL_SPACING;
        var widthButton = dc.getWidth() / 2;
        var highlighted = new Ui.Bitmap({:rezId=>Rez.Drawables.buttonResetSelected});
        var options = {
            :locX=>0,
            :locY=>initialY,
            :width=>widthButton,
            :height=>heightButton,
            :behavior=>:onPlayer1,
            :stateHighlighted=>Gfx.COLOR_RED
            };
        playerButtons = new [2];
        playerButtons[0] = new Button(options);

        options.put(:locX, dc.getWidth() / 2);
        options.put(:behavior, :onPlayer2);
        playerButtons[1] = new Button(options);
        setLayout(playerButtons);
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
        // If device does not have touch screen, let's activate
        // the hard key to be able to click player buttons.
        if (!System.getDeviceSettings().isTouchScreen) {
            setKeyToSelectableInteraction(true);
        }
    }

    //! Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.setPenWidth(2);
        if (dataTracker.getSession().isRecording()) {
            dataTracker.update();
        }
        var time = dataTracker.getSession().getElapsedTime();

        var x = dc.getWidth() / 2 - HORIZONTAL_SPACING;
        var y = initialY;

        drawPlayerButton(dc, x, y, Ui.loadResource(Rez.Strings.player1_score_label), dataTracker.getPlayer1Score());
        x = dc.getWidth() / 2 + HORIZONTAL_SPACING;
        drawPlayerButton(dc, x, y, Ui.loadResource(Rez.Strings.player2_score_label), dataTracker.getPlayer2Score());
        x = dc.getWidth() / 2 - HORIZONTAL_SPACING;
        // Size of label field
        y = y + dc.getFontHeight(Gfx.FONT_TINY) + VERTICAL_SPACING;
        // Size of score field
        y = y + dc.getFontHeight(Gfx.FONT_NUMBER_MILD) + (VERTICAL_SPACING / 2);
        dc.drawLine(0, y, dc.getWidth(), y);
        y = y + (VERTICAL_SPACING / 2);

        x = dc.getWidth() / 2 - HORIZONTAL_SPACING;
        dc.drawText(x, y, Gfx.FONT_TINY, Ui.loadResource(Rez.Strings.steps_label), Gfx.TEXT_JUSTIFY_RIGHT);
        x = dc.getWidth() / 2 + HORIZONTAL_SPACING;
        dc.drawText(x, y, Gfx.FONT_TINY, Ui.loadResource(Rez.Strings.hr_label), Gfx.TEXT_JUSTIFY_LEFT);
        y = y + dc.getFontHeight(Gfx.FONT_TINY) + VERTICAL_SPACING;
        x = dc.getWidth() / 2 - HORIZONTAL_SPACING;
        dc.drawText(x, y, Gfx.FONT_NUMBER_MILD, dataTracker.getNumberOfSteps(), Gfx.TEXT_JUSTIFY_RIGHT);
        x = dc.getWidth() / 2 + HORIZONTAL_SPACING;
        dc.drawText(x, y, Gfx.FONT_NUMBER_MILD, heartRate, Gfx.TEXT_JUSTIFY_LEFT);

        y = y + dc.getFontHeight(Gfx.FONT_NUMBER_MILD) + (VERTICAL_SPACING / 2);
        dc.drawLine(0, y, dc.getWidth(), y);
        y = y + (VERTICAL_SPACING / 2);

        x = dc.getWidth() / 2 - HORIZONTAL_SPACING;
        dc.drawText(x, y, Gfx.FONT_TINY, Ui.loadResource(Rez.Strings.time_label), Gfx.TEXT_JUSTIFY_RIGHT);

        x = dc.getWidth() / 2 + HORIZONTAL_SPACING;
        dc.drawText(x, y, Gfx.FONT_TINY, Ui.loadResource(Rez.Strings.calories_label), Gfx.TEXT_JUSTIFY_LEFT);

        y = y + dc.getFontHeight(Gfx.FONT_TINY) + VERTICAL_SPACING;
        x = dc.getWidth() / 2 - HORIZONTAL_SPACING;
        dc.drawText(x, y, Gfx.FONT_NUMBER_MILD, time, Gfx.TEXT_JUSTIFY_RIGHT);

        x = dc.getWidth() / 2 + HORIZONTAL_SPACING;
        dc.drawText(x, y, Gfx.FONT_NUMBER_MILD, dataTracker.getNumberOfCalories(), Gfx.TEXT_JUSTIFY_LEFT);

        y = y + dc.getFontHeight(Gfx.FONT_NUMBER_MILD) + (VERTICAL_SPACING / 2);
        dc.drawLine(0, y, dc.getWidth(), y);
        y = y + (VERTICAL_SPACING / 2);

        x = dc.getWidth() / 2;
        dc.drawLine(x, VERTICAL_SPACING, x, y);
    }

    //! Draws nicely Player 1 or 2 buttons, considering if they are
    //! highlithed or not.
    //! @param dc     Where to draw it
    //! @param label  Label that indicates which player it is
    //! @param score  Score to draw in the button
    hidden function drawPlayerButton(dc, x, y, label, score){
        var justify = Gfx.TEXT_JUSTIFY_RIGHT;
        var button = 0;
        if (label.equals(Ui.loadResource(Rez.Strings.player2_score_label))) {
            justify = Gfx.TEXT_JUSTIFY_LEFT;
            button = 1;
        }
        if (playerButtons[button].getState() == :stateHighlighted){
            dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_RED);
        } else {
            dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        }
        dc.drawText(x, y, Gfx.FONT_TINY, label, justify);
        y = y + dc.getFontHeight(Gfx.FONT_TINY) + VERTICAL_SPACING;
        dc.drawText(x, y, Gfx.FONT_NUMBER_MILD, score, justify);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
        setKeyToSelectableInteraction(false);
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
