using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class SquashApp extends App.AppBase {

	hidden var dataTracker;

    function initialize() {
        AppBase.initialize();
        dataTracker = new DataTracker();
    }

    //! onStart() is called on application start up
    function onStart(state) {
    	AppBase.onStart(state);
    }

    //! onStop() is called when your application is exiting
    function onStop(state) {
    	// Stop the recoding session in case it was
    	// not stopped before.
    	dataTracker.getSession().stop();
    }

    //! Return the initial view of your application here
    function getInitialView() {
        return [new SquashView(dataTracker), new SquashDelegate(dataTracker) ];
    }

}
