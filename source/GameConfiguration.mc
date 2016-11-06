using Toybox.WatchUi as Ui;
using Toybox.Application as App;

//! Class that holds the configuration of the game
//! as total number of sets and the max score in
//! one set. It reads the configuration from
//! the object store of the application.
class GameConfiguration {

    hidden var setMaxScore;
    hidden var setTotalSets;
    hidden var player1Name;
    hidden var player2Name;
    static var instance = null;
    
    static function getInstance() {
        if (instance == null) {
            instance = new GameConfiguration();
        }
        return instance;
    }

    function initialize() {
        setMaxScore = readKeyInt("setMaxScore", 11);
        setTotalSets = readKeyInt("setTotalSets", 5);
        player1Name = readString("player1Name", 8, Ui.loadResource(Rez.Strings.player1_score_label));
        player2Name = readString("player2Name", 8, Ui.loadResource(Rez.Strings.player2_score_label));
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
    
    hidden function readString(key, length, thisDefault) {
        var value = App.getApp().getProperty(key);
        
        if(value == null) {
            value = thisDefault;
        }
        return value.substring(0, length);
    }
    
    function getMaxScore() {
        return setMaxScore;
    }
    
    function getTotalSets() {
        return setTotalSets;
    }
    
    function getPlayer1Name(){
        return player1Name;
    }
    
    function getPlayer2Name() {
        return player2Name;
    }
}