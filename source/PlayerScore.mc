using Toybox.Graphics as Gfx;

class PlayerScore {
	var width, height;
	var xStart, yStart;
	var xEnd, yEnd;
	var score;
	var dc;
	var xOffset = 5;
	var yOffset = 2;
	var name;
	var scoreYOffset;
	
	function initialize(name) {
		score = 0;
		self.name = name;
	}
	
	function setConfiguration(dc, xStart){
		self.dc = dc;
		self.xStart = xStart + xOffset;
		self.yStart = dc.getFontHeight(Gfx.FONT_SMALL) + yOffset*3;
		self.width = (dc.getWidth() / 2) - 10;
		self.height = dc.getFontHeight(Gfx.FONT_SMALL) * 2 + yOffset;
		self.scoreYOffset = dc.getFontHeight(Gfx.FONT_TINY) + yOffset;
		xEnd = self.xStart + self.width;
		yEnd = self.yStart + self.height;
	}
	
	function draw() {
	    var x = dc.getWidth() / 2;
        dc.drawRectangle(xStart, yStart, width, height);
        dc.drawText(xStart + xOffset + 3, yStart+yOffset, Gfx.FONT_TINY, name, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(xStart + xOffset + 23, yStart+scoreYOffset, Gfx.FONT_SMALL, score, Gfx.TEXT_JUSTIFY_LEFT);
	}

}
