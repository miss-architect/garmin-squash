using Toybox.WatchUi as Ui;

class SquashDelegate extends Ui.BehaviorDelegate {

	hidden var player1Score, player2Score;

    function initialize(player1Score, player2Score) {
        BehaviorDelegate.initialize();
        self.player1Score = player1Score;
        self.player2Score = player2Score;
    }

    function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new SquashMenuDelegate(), Ui.SLIDE_UP);
        return true;
    }
    
    /*function onSwipe(evt)
    {
        var swipe = evt.getDirection();

        if( swipe == SWIPE_UP )
        {
            setActionString("SWIPE_UP");
        }
        else if( swipe == SWIPE_RIGHT )
        {
            setActionString("SWIPE_RIGHT");
        }
        else if( swipe == SWIPE_DOWN )
        {
            setActionString("SWIPE_DOWN");
        }
        else if( swipe == SWIPE_LEFT )
        {
            setActionString("SWIPE_LEFT");
        }

        return true;
    }*/
    
    function onTap(evt)
    {
    	var x = evt.getCoordinates()[0];
    	var y = evt.getCoordinates()[1];
        if (isHitting(x,y, player1Score)) {
        	self.player1Score.score++;
        	Ui.requestUpdate();
        }
        else if (isHitting(x,y, player2Score)) {
        	player2Score.score++;
        	Ui.requestUpdate();
        }
        return true;
    }
    
    function isHitting(x, y, playerScore) {
    	return (((x > playerScore.xStart) && (x < playerScore.xEnd)) && 
    			((y > playerScore.yStart) && (y < playerScore.yEnd)));
    }

}