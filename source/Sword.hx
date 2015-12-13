
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

class Sword extends FlxSprite {

	private var player:Player;
	private var falling = false;

	public function new(X:Float, Y:Float, player:Player){
		super(X, Y);
		this.player = player;
		setFacingFlip(FlxObject.LEFT,true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		/*makeGraphic(16, 64, FlxColor.RED);*/
		loadGraphic("assets/images/sword.png", true, 16,64);
		/*
		animation.add("idle", [0,1,2,1], 4);
		animation.add("walk", [3,5,4,5], 4);
		animation.add("jump", [6,7,8,9,10], 5, false);
		animation.add("fall", [10,9,8,7,6], 5, false);
		animation.play("idle");*/
		// Basic player physics


		//gibs.makeParticles(Reg.GIBS, 100, 10, true, 0.5);
	}


	override public function update():Void {

		/*trace(player.velocity.y);*/
		var modifier = -1;
		facing = player.facing;
		if(this.player.velocity.y < 0 && this.facing == FlxObject.LEFT
			|| this.player.velocity.y > 0 && this.facing == FlxObject.RIGHT){
			modifier = 1;
		}
		this.angle = Math.min(Math.max(modifier*(player.velocity.y/player.jumpPower)*180, -180), 180);
		/*trace(this.angle);*/
		this.x = this.player.x - 40*Math.cos((this.angle+90) * FlxAngle.TO_RAD);// + player.velocity.y/10;
		this.y = this.player.y -20 - 40*Math.sin((this.angle+90) * FlxAngle.TO_RAD);// + player.velocity.y/10;
		super.update();
	}


}
