
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
import flixel.FlxState;
import flixel.util.FlxRandom;

class Spawner extends FlxObject {

	private var state:PlayState;
	private var objects:FlxTypedGroup<FlxSprite>;
	private var birds:FlxTypedGroup<FlxSprite>;

	public function new(X:Float, Y:Float, state:PlayState, objects:FlxTypedGroup<FlxSprite>, birds:FlxTypedGroup<FlxSprite>){
		super(X, Y);
		this.state = state;
		this.objects = objects;
		this.birds = birds;
	}

	public function spawn() {
		var spawned:FlxSprite = null;
		switch(FlxRandom.intRanged(0,2)) {
			case 0:
				spawned = new Enemy(x,y-32, state.map);
				spawned.width = 32;
				spawned.height = 64;
				objects.add(spawned);
			case 1:
				spawned = new Bird(x,y);
				spawned.width = 32;
				spawned.height = 32;
				birds.add(spawned);
			case 2:
				spawned = new Canon(x,y, state.map, state.bullets, state.player);
				spawned.width = 64;
				spawned.height = 32;
				objects.add(spawned);
		}
		state.add(spawned);
	}

}
