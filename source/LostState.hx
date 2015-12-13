package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class LostState extends FlxSubState {

	public var score:Float;
	public function new(score) {
		this.score = score;
		super();
	}

	public override function create() {
		var goText = new FlxText(100,100,800, "You lost ! Your score : " + score, 30);
		goText.scrollFactor.x = goText.scrollFactor.y = 0;
		goText.borderSize = 1;
		goText.borderStyle = FlxText.BORDER_OUTLINE;
		goText.borderColor = 0x838383;
		goText.color = 0xf2878c;
		add(goText);
		var goText2 = new FlxText(100,200,800, "Press left or right to restart", 30);
		goText2.scrollFactor.x = goText2.scrollFactor.y = 0;
		goText2.borderSize = 1;
		goText2.borderStyle = FlxText.BORDER_OUTLINE;
		goText2.borderColor = 0x838383;
		goText2.color = 0xf2878c;
		add(goText2);
		super.create();
	}



	public override function update() {
		if (FlxG.keys.anyPressed(["LEFT", "RIGHT"])) {
			FlxG.resetState();
		}

		super.update();
	}

}
