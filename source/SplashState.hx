package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class SplashState extends FlxSubState {

	public function new() {
		super();
	}

	public override function create() {
		var goText = new FlxText(100,100,800, "Press left or right to flap", 30);
		goText.scrollFactor.x = goText.scrollFactor.y = 0;
		goText.borderSize = 1;
		goText.borderStyle = FlxText.BORDER_OUTLINE;
		goText.borderColor = 0x838383;
		goText.color = 0xf2878c;
		add(goText);
		super.create();
	}



	public override function update() {
		if (FlxG.keys.anyPressed(["LEFT", "RIGHT"])) {
		close();
		}

		super.update();
	}

}
