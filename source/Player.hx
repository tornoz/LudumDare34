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

class Player extends FlxSprite {

	public var maxHp = 100;

	public var jumpPower:Int = 500;
	public var runSpeed:Int = 200;
	public var hp:Float = 100;
	public var shootRate = 1/2;
	public var meltingPerSecond = 2;
	public var dmg:Float = 1;
	public var bulletSpeed = 200;

	public var maxJumpPower = 900;
	public var maxRunSpeed = 900;
	public var wait = false;
	private var shootCounter:Float;
	private var aim:Int;
	public var isReadyToJump:Bool = true;
	public var invincibleTime:Float = 0.5;
	public var invincibleTimer:Float = 0;
	public var hitback = 500;
	public var hit:Bool = false;
	public var gibs:FlxEmitter;
	private var _whitePixel:FlxParticle;

		private var flapTime:Float = 0.1;
	private var flapCounter:Float = 0;


	public function new(X:Int, Y:Int){
		super(X, Y);

		setFacingFlip(FlxObject.RIGHT,true, false);
		setFacingFlip(FlxObject.LEFT, false, false);
		/*makeGraphic(32, 64, FlxColor.GREEN);*/
		loadGraphic("assets/images/player.png", true, 32,64);
		/*
		animation.add("idle", [0,1,2,1], 4);
		animation.add("walk", [3,5,4,5], 4);
		animation.add("jump", [6,7,8,9,10], 5, false);
		animation.add("fall", [10,9,8,7,6], 5, false);
		animation.play("idle");*/
		// Basic player physics

		/*drag.x = runSpeed * 8;*/
		acceleration.y = 1040;

		maxVelocity.set(runSpeed, maxJumpPower);

		//gibs.makeParticles(Reg.GIBS, 100, 10, true, 0.5);
	}


	override public function update():Void {

		if(flapCounter > 0) {
			flapCounter -= FlxG.elapsed;
		}
		if (FlxG.keys.justPressed.LEFT && !wait)	{

			this.jump(-1);
			facing = FlxObject.LEFT;
		} else if (FlxG.keys.justPressed.RIGHT && !wait) {
			facing = FlxObject.RIGHT;
			this.jump(1);
		}
		if(velocity.y == 0 && isTouching(FlxObject.FLOOR)) {

			velocity.x = 0;
		}
		super.update();
	}

	public function jump(side:Int):Void	{
		/*if (isReadyToJump && (velocity.y == 0))
			{*/
			if(flapCounter <=0) {
				FlxG.camera.shake(0.008,0.02);
					velocity.y = -jumpPower;
					velocity.x = side*runSpeed;
					flapCounter = flapTime;
				}

			/*}*/
	}

}
