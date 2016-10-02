using Toybox.Application as App;

//! Class that holds the configuration of the game
//! as total number of sets and the max score in
//! one set. It reads the configuration from
//! the object store of the application.
class GameConfiguration {

    hidden var setMaxScore;
    hidden var setTotalSets;

    function initialize() {
        setMaxScore = readKeyInt("setMaxScore", 11);
        setTotalSets = readKeyInt("setTotalSets", 5);
    }

    // make sure property is of type number
    // see https://webcache.googleusercontent.com/search?cd=2&hl=en&ct=clnk&gl=ch&
    //     q=cache:0hxHRJ_80hcJ:https://forums.garmin.com/archive/index.php/t-359183.html+
    hidden function readKeyInt(key, thisDefault) {
        var value = App.getApp().getProperty(key);

        if(value == null || !(value instanceof Number)) {
            if(value != null) {
                value = value.toNumber();
            } else {
                value = thisDefault;
            }
        }
        return value;
    }
    
    function getMaxScore() {
        return setMaxScore;
    }
    
    function getTotalSets() {
        return setTotalSets;
    }
}