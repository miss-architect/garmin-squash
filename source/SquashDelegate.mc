using Toybox.WatchUi as Ui;

class SquashDelegate extends Ui.BehaviorDelegate {

	hidden var player1Score, player2Score;
	hidden var scores;

    function initialize(scores) {
        BehaviorDelegate.initialize();
        self.scores = scores;
    }

    function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new SquashMenuDelegate(), Ui.SLIDE_UP);
        return true;
    }
    
    function onReset() {
    	scores.reset();
    }
    
    function onPlayer1(){
    	scores.player1Score++;
    }
    
    function onPlayer2(){
    	scores.player2Score++;
    }

}