using Toybox.WatchUi as Ui;
using Toybox.Time as Time;

//! Class that handles events coming from
//! the Squash View
class SquashDelegate extends Ui.BehaviorDelegate {

    //! Object that contains the data that will
    //! be displayed on screen
    hidden var dataTracker;

    //! Constructor
    //! @param dataTracker Shared objtect that contains 
    //!       the data that will be displayed on screen
    function initialize(dataTracker) {
        BehaviorDelegate.initialize();
        self.dataTracker = dataTracker;
    }

    //! Function called when the menu button is pressed
    //! In this view, it should start or stop recording
    //! the session
    function onMenu() {
        if (dataTracker.getSession().isRecording()) {
            //TODO: Implement this logic in a more encapsulated way
            dataTracker.getSession().saveGameScore(dataTracker.getGameScore()[0], dataTracker.getGameScore()[1]);
            dataTracker.getSession().stop();
        }
        else {
            // Let's set all counters to 0, just in case
            dataTracker.restart();
            dataTracker.getSession().start();
        }
        Ui.requestUpdate();
        return true;
    }

    //! Function called when the reset button of the UI is pressed.
    function onReset() {
        dataTracker.reset();
    }

    //! Function called when the player 1 score button is pressed.
    function onPlayer1(){
        if (dataTracker.getSession().isRecording() &&
            dataTracker.incrementPlayer1Score()) {
            if (!dataTracker.isGameOver()) {
                dataTracker.getSession().addLap();
                Ui.pushView(new WinSetView({:player=>Ui.loadResource(Rez.Strings.player1_score_label),
                                            :gameScore=>dataTracker.getGameScore()}),
                            new Ui.BehaviorDelegate(), Ui.SLIDE_IMMEDIATE);
            }
            else {
                Ui.pushView(new WinGameView({:player=>Ui.loadResource(Rez.Strings.player1_score_label),
                                :dataTracker=>dataTracker}),
                            new WinGameDelegate(dataTracker), Ui.SLIDE_IMMEDIATE);
            }
        }
    }

    //! Function called when the player 2 score button is pressed.
    function onPlayer2(){
        if (dataTracker.getSession().isRecording() &&
            dataTracker.incrementPlayer2Score()) {
            if (!dataTracker.isGameOver()) {
                dataTracker.getSession().addLap();
                Ui.pushView(new WinSetView({:player=>Ui.loadResource(Rez.Strings.player2_score_label),
                                :gameScore=>dataTracker.getGameScore()}),
                            new Ui.BehaviorDelegate(), Ui.SLIDE_IMMEDIATE);
            }
            else {
                Ui.pushView(new WinGameView({:player=>Ui.loadResource(Rez.Strings.player2_score_label), 
                                :dataTracker=>dataTracker}),
                            new WinGameDelegate(dataTracker), Ui.SLIDE_IMMEDIATE);
            }
        }
    }
}