
package;



import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.ui.FlxButton;
import flixel.ui.FlxVirtualPad;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;
import flixel.util.FlxPoint;
import flixel.util.FlxColor;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.util.FlxAngle;

class Bird extends FlxSprite {

		public var jumpPower:Int = 500;
		public var runSpeed:Int = 150;
		public var map:TiledLevel;
		public static var THEONE = 0;
		public var isTheOne = false;
	public function new(X:Float, Y:Float){
		super(X, Y);
		this.elasticity = 1;
		setFacingFlip(FlxObject.RIGHT,true, false);
		setFacingFlip(FlxObject.LEFT, false, false);
		/*makeGraphic(32, 64, FlxColor.BLUE);*/
		loadGraphic("assets/images/bird.png", true, 32,32);

		animation.add("fly", [0,1], 4);
		/*animation.add("jump", [6,7,8,9,10], 5, false);
		animation.add("fall", [10,9,8,7,6], 5, false);*/
		animation.play("fly");
		//animation.add("idle", [0,1,2,1], 4);
		// Basic player physics
		this.health = 1;
		this.velocity.x = runSpeed;
		this.velocity.y = runSpeed;
		if(THEONE == 0) {
			THEONE = 1;
			this.isTheOne = true;
		}
		/*if(this.isTheOne) {
			makeGraphic(32, 64, FlxColor.PURPLE);
		}*/

		//gibs.makeParticles(Reg.GIBS, 100, 10, true, 0.5);
	}


	override public function update():Void {
		super.update();
	}



}
