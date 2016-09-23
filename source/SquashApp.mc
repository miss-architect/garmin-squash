using Toybox.System;
using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Sensor as Snsr;

//! Class that represents the Squash Application
class SquashApp extends App.AppBase {

    //! Object that contains the data that will
    //! be displayed on screen
    hidden var dataTracker;

    //! Points to win a set
    hidden var setMaxScore = 99;

    //! Sets to win a match
    hidden var setTotalSets = 98;

    //! Constructor
    function initialize() {
        AppBase.initialize();
        setMaxScore = readKeyInt("setMaxScore", 11);
        setTotalSets = readKeyInt("setTotalSets", 5);
        dataTracker = new DataTracker(setMaxScore, setTotalSets);
    }

    //! onStart() is called on application start up
    function onStart(state) {
        AppBase.onStart(state);
    }

    //! onStop() is called when the application is exiting
    function onStop(state) {
        // Stop the recoding session in case it was
        // not stopped before.
        if (dataTracker.getSession().isRecording()) {
            //TODO: Implement this logic in a more encapsulated way
            dataTracker.getSession().saveGameScore(dataTracker.getGameScore()[0], dataTracker.getGameScore()[1]);
            dataTracker.getSession().stop();
        }
        // Let's disable the heart rate sensor
        Snsr.setEnabledSensors([]);
    }

    //! Return the initial view of application
    function getInitialView() {
        return [new SquashView(dataTracker), new SquashDelegate(dataTracker) ];
    }

    // make sure property is of type number
    // see https://webcache.googleusercontent.com/search?cd=2&hl=en&ct=clnk&gl=ch&
    //     q=cache:0hxHRJ_80hcJ:https://forums.garmin.com/archive/index.php/t-359183.html+
    function readKeyInt(key, thisDefault) {
        var value = Application.getApp().getProperty(key);

        if(value == null || !(value instanceof Number)) {
            if(value != null) {
                value = value.toNumber();
            } else {
                value = thisDefault;
            }
        }
        return value;
    }
}
