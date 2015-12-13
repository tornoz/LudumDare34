
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

class Canon extends FlxSprite {

		public var jumpPower:Int = 500;
		public var runSpeed:Int = 50;
		public var map:TiledLevel;
		public static var THEONE = 0;
		public var isTheOne = false;
		public var dmg = 1;

		public var bulletSpeed = 200;
		public var bullets:FlxTypedGroup<CanonBullet>;
		public var player:Player;
		private var shootCounter:Float;
		public var shootRate = 1;
	public function new(X:Float, Y:Float, map:TiledLevel, bullets:FlxTypedGroup<CanonBullet>, player:Player){
		super(X, Y);
		this.map = map;
		setFacingFlip(FlxObject.RIGHT,true, false);
		setFacingFlip(FlxObject.LEFT, false, false);
		/*makeGraphic(32, 64, FlxColor.BLUE);*/
		loadGraphic("assets/images/canon.png", true, 64,32);
		this.player = player;
		this.bullets = bullets;
		animation.add("walk", [0,1], 4);
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
		this.shootCounter = 0.1;
		/*if(this.isTheOne) {
			makeGraphic(32, 64, FlxColor.PURPLE);
		}*/

		//gibs.makeParticles(Reg.GIBS, 100, 10, true, 0.5);
	}

	public function canGoForward(){
		return this.map.tilemap.getTile(Std.int(this.getForwardX()), Std.int(this.getTileY() +1)) > 6;
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
		if(Std.int(player.y/32) == (Std.int(this.y/32)-1)) {
			if(shootCounter > 0)
				shootCounter -= FlxG.elapsed;
			shoot();
		}
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


		public function shoot():Void{

			if (shootCounter > 0) {
					return;
			}
			shootCounter = shootRate;
			var point = new FlxPoint(x+width/2, y + height - 8);
			bullets.recycle(CanonBullet, [bullets, bulletSpeed, dmg]).shoot(point, facing);
		}



}
