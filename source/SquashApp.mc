using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class SquashApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    //! onStart() is called on application start up
    function onStart() {
    }

    //! onStop() is called when your application is exiting
    function onStop() {
    }

    //! Return the initial view of your application here
    function getInitialView() {
    	var player1Score = new PlayerScore("Player 1");
		var player2Score = new PlayerScore("Player 2");
        return [new SquashView(player1Score, player2Score), new SquashDelegate(player1Score, player2Score) ];
    }

}
