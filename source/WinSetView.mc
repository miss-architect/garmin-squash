using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class WinSetView extends Ui.View {

	hidden var data;
	hidden const VERTICAL_SPACE = 2;

    function initialize(data) {
        View.initialize();
        self.data = data;
    }

    function onUpdate(dc) {
    	View.onUpdate(dc);
    	var x = dc.getWidth() / 2;
    	var y = dc.getHeight() / 4;
    	dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_BLACK);
        dc.drawText(x, y, Gfx.FONT_LARGE, data[:player], Gfx.TEXT_JUSTIFY_CENTER);
        dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);
        y = y + dc.getFontHeight(Gfx.FONT_LARGE) + VERTICAL_SPACE;
        dc.drawText(x, y, Gfx.FONT_MEDIUM, "won the set", Gfx.TEXT_JUSTIFY_CENTER);
        y = y + dc.getFontHeight(Gfx.FONT_MEDIUM) + VERTICAL_SPACE;
        dc.drawText(x, y, Gfx.FONT_SMALL, "Game score" , Gfx.TEXT_JUSTIFY_CENTER);
        y = y + dc.getFontHeight(Gfx.FONT_SMALL) + VERTICAL_SPACE;
        var gameScore = data[:gameScore];
        dc.drawText(x, y, Gfx.FONT_SMALL,  gameScore[0] + " - " + gameScore[1], Gfx.TEXT_JUSTIFY_CENTER);
    }

}