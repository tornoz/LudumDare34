package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.group.FlxTypedGroup;
import flixel.FlxObject;
import flixel.util.FlxPoint;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{

	public var map:TiledLevel;
	public var player:Player;
	private var sword:Sword;
	public var bullets:FlxTypedGroup<CanonBullet>;
	private var objects:FlxTypedGroup<FlxSprite>;
	private var birds:FlxTypedGroup<FlxSprite>;
	private var spawners:FlxTypedGroup<Spawner>;

	public var pointTxt:FlxText;
	private var spawnTime:Float = 6;
	private var spawnCounter:Float = 1;

	private var score:Float = 0;
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		FlxG.mouse.visible = false;
		this.map = new TiledLevel("assets/data/map1.tmx");


		var bg = new FlxSprite(0, 0, 'assets/images/bg.png');
		bg.scrollFactor.x = 0.25;
		bg.scrollFactor.y = 0.25;
		add(bg);

		add(this.map.tilemap);
		this.map.loadObjects(this);
		this.pointTxt = new FlxText(0,0,800,"0",15);
		pointTxt.scrollFactor.x = pointTxt.scrollFactor.y = 0;
		pointTxt.borderSize = 1;
		pointTxt.borderStyle = FlxText.BORDER_OUTLINE;
		pointTxt.borderColor = 0x838383;
		pointTxt.color = 0xf2878c;
		add(pointTxt);
		this.objects = map.objects;
		this.player = map.player;
		this.birds = map.birds;
		this.bullets = map.bullets;
		this.spawners = map.spawners;
		this.sword = new Sword(this.player.x, this.player.y, this.player);
		add(sword);
		add(bullets);
		FlxG.camera.follow( player, flixel.FlxCamera.STYLE_PLATFORMER );
		FlxG.camera.setBounds(0, 0, map.width*32, map.height*32);
		FlxG.worldBounds.copyFrom(map.tilemap.getBounds());


		openSubState( new SplashState());
		super.create();
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		this.spawnCounter -= FlxG.elapsed;
		if(this.spawnCounter < 0) {
			this.spawn();
			spawnCounter = this.spawnTime;
			spawnTime -= 0.1;
			if(spawnTime < 1) {
				spawnTime = 1;
			}
		}
		this.map.collideWithLevel(this.player);
		this.map.collideWithLevel(this.birds);
		this.map.collideWithLevel(this.bullets);
		FlxG.overlap(this.sword, this.objects, hitEnemy);
		FlxG.overlap(this.sword, this.birds, hitEnemy);
		FlxG.collide(this.player, this.objects, hitPlayer);
		FlxG.collide(this.player, this.bullets, hitPlayer);
		FlxG.collide(this.player, this.birds, hitPlayer);
		super.update();
	}

	public function spawn() {
	var spawner = spawners.getRandom();
		if(FlxMath.distanceToPoint(player, FlxPoint.get(spawner.x, spawner.y)) > 500) {
			spawner.spawn();

		} else {
			spawn();
			return;
		}
	}

	public function hitEnemy(sword:FlxSprite, enemy:FlxSprite)
	{
		FlxG.camera.shake(0.02,0.1);
		score++;
		pointTxt.text = "" + score;
		enemy.hurt(1);
	}


	public function hitPlayer(player:FlxSprite, enemy:FlxSprite)
	{
		player.hurt(1);
		openSubState( new LostState(score));
	}


}
