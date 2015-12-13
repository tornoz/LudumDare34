
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

class Enemy extends FlxSprite {

		public var jumpPower:Int = 500;
		public var runSpeed:Int = 150;
		public var map:TiledLevel;
		public static var THEONE = 0;
		public var isTheOne = false;
		public var gibs:FlxEmitter;
		private var _redPixel:FlxParticle;


	public function new(X:Float, Y:Float, map:TiledLevel){
		super(X, Y);
		this.map = map;
		setFacingFlip(FlxObject.RIGHT,true, false);
		setFacingFlip(FlxObject.LEFT, false, false);
		/*makeGraphic(32, 64, FlxColor.BLUE);*/
		loadGraphic("assets/images/enemy.png", true, 32,64);

		animation.add("walk", [0,1,0,2], 4);
		/*animation.add("jump", [6,7,8,9,10], 5, false);
		animation.add("fall", [10,9,8,7,6], 5, false);*/
		animation.play("walk");
		//animation.add("idle", [0,1,2,1], 4);
		// Basic player physics
		this.health = 1;
		this.velocity.x = runSpeed;
		if(THEONE == 0) {
			THEONE = 1;
			this.isTheOne = true;
		}
		/*if(this.isTheOne) {
			makeGraphic(32, 64, FlxColor.PURPLE);
		}*/


		gibs = new FlxEmitter();
		gibs.setXSpeed( -150, 150);
		gibs.setYSpeed( -200, 0);
		gibs.setRotation( -720, -720);
		gibs.gravity = 350;
		gibs.bounce = 0.5;
		//gibs.makeParticles(Reg.GIBS, 100, 10, true, 0.5);
	}

	public function canGoForward(){
		return this.map.tilemap.getTile(Std.int(this.getForwardX()), Std.int(this.getTileY() +2)) > 6;
	}
	public function getTileX() {
		return this.x / this.map.tileWidth;
	}
	public function getTileY() {
		return this.y / this.map.tileHeight;
	}
	public function getForwardX() {
		if(this.facing == FlxObject.LEFT) {
			return this.getTileX() - 1;
		} else {
			return this.getTileX() + 1;
		}
	}

	override public function update():Void {
		super.update();
		if(this.isTheOne) {
			/*trace(this.map.tilemap.getTile(Std.int(this.getForwardX()), Std.int(this.getTileY() +2)));*/
		}
		if(!this.canGoForward()) {
			if(this.isTheOne) {
				/*trace("I CANT GO FORWARD :'(");*/
			}
			this.velocity.x = -this.velocity.x;
			if(this.facing == FlxObject.LEFT) {
					this.facing = FlxObject.RIGHT;
			} else {
				this.facing = FlxObject.LEFT;
			}
		}
	}

	override function hurt(damage:Float) {
		for (i in 0...10)
			{
				_redPixel = new FlxParticle();
				_redPixel.makeGraphic(2, 2, FlxColor.RED);
				// Make sure the particle doesn't show up at (0, 0)
				_redPixel.visible = false;
				gibs.add(_redPixel);
				_redPixel = new FlxParticle();
				_redPixel.makeGraphic(1, 1, FlxColor.RED);
				_redPixel.visible = false;
				gibs.add(_redPixel);
			}
			gibs.at(this);
			gibs.start(true, 2, 0, 50);
			super.hurt(damage);

	}




}
