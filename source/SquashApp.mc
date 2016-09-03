using Toybox.Application as App;
using Toybox.WatchUi as Ui;

//! Class that represents the Squash Application
class SquashApp extends App.AppBase {

	//! Object that contains the data that will
	//! be displayed on screen
	hidden var dataTracker;

	//! Constructor
    function initialize() {
        AppBase.initialize();
        dataTracker = new DataTracker();
    }

    //! onStart() is called on application start up
    function onStart(state) {
    	AppBase.onStart(state);
    }

    //! onStop() is called when the application is exiting
    function onStop(state) {
    	// Stop the recoding session in case it was
    	// not stopped before.
    	//TODO: Implement this logic in a more encapsulated way
    	dataTracker.getSession().saveGameScore(dataTracker.getGameScore()[0], dataTracker.getGameScore()[1]);
    	dataTracker.getSession().stop();
    }

    //! Return the initial view of application
    function getInitialView() {
        return [new SquashView(dataTracker), new SquashDelegate(dataTracker) ];
    }

}
