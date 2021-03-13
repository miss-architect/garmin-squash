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
                Ui.pushView(new WinSetView({:player=>GameConfiguration.getInstance().getPlayer1Name(),
                                            :gameScore=>dataTracker.getGameScore()}),
                            new Ui.BehaviorDelegate(), Ui.SLIDE_IMMEDIATE);
            }
            else {
                Ui.pushView(new WinGameView({:player=>GameConfiguration.getInstance().getPlayer1Name(),
                                :dataTracker=>dataTracker}),
                            new WinGameDelegate(dataTracker), Ui.SLIDE_IMMEDIATE);
            }
            dataTracker.changeServingPlayer(Player.NO_PLAYER);
        }
        else {
            dataTracker.changeServingPlayer(Player.PLAYER_1);
        }
    }

    //! Function called when the player 2 score button is pressed.
    function onPlayer2(){
        if (dataTracker.getSession().isRecording() &&
            dataTracker.incrementPlayer2Score()) {
            if (!dataTracker.isGameOver()) {
                dataTracker.getSession().addLap();
                Ui.pushView(new WinSetView({:player=>GameConfiguration.getInstance().getPlayer2Name(),
                                :gameScore=>dataTracker.getGameScore()}),
                            new Ui.BehaviorDelegate(), Ui.SLIDE_IMMEDIATE);
            }
            else {
                Ui.pushView(new WinGameView({:player=>GameConfiguration.getInstance().getPlayer2Name(),
                                :dataTracker=>dataTracker}),
                            new WinGameDelegate(dataTracker), Ui.SLIDE_IMMEDIATE);
            }
            dataTracker.changeServingPlayer(Player.NO_PLAYER);
        }
        else {
            dataTracker.changeServingPlayer(Player.PLAYER_2);
        }
    }

    //! Event used in non-touchscreen devices to
    //! increment player 2 score
    function onNextPage() {
      if (!System.getDeviceSettings().isTouchScreen) {
        onPlayer2();
      }
    }

    //! Event used in non-soutchscreen devices to
    //! increment player 1 score
    function onPreviousPage() {
      if (!System.getDeviceSettings().isTouchScreen) {
        onPlayer1();
      }
    }

    //! Event used when back button is pressed.
    //! It shows a confirmation dialig before quitting the App
    function onBack() {
        Ui.pushView(new Confirmation(Ui.loadResource(Rez.Strings.confirm_exit)),
            new ExitConfirmationDelegate(), Ui.SLIDE_IMMEDIATE);
        return true;
    }

}

//! Delegate that handles the event from the Confirmation dialog
//! that appears before quitting the App.
class ExitConfirmationDelegate extends Ui.ConfirmationDelegate {

    function initialize() {
        ConfirmationDelegate.initialize();
    }

    //! Event that happens on response of the user.
    //! When the user replies YES, then the App exits.
    function onResponse(response) {
        if (response == CONFIRM_YES) {
            System.exit();
        }
    }
}