using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class SquashApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    //! onStart() is called on application start up
    function onStart(state) {
    	AppBase.onStart(state);
    }

    //! onStop() is called when your application is exiting
    function onStop(state) {
    }

    //! Return the initial view of your application here
    function getInitialView() {
    	var scores = new PlayerScores();
        return [new SquashView(scores), new SquashDelegate(scores) ];
    }

}
