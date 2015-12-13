package;
import openfl.Assets;
import haxe.io.Path;
import haxe.xml.Parser;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.group.FlxTypedGroup;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectGroup;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.addons.tile.FlxTilemapExt;
/**
 * ...
 * @author Samuel Batista
 */
class TiledLevel extends TiledMap
{
	// For each "Tile Layer" in the map, you must define a "tileset" property which contains the name of a tile sheet image
	// used to draw tiles in that layer (without file extension). The image file must be located in the directory specified bellow.
	private inline static var c_PATH_LEVEL_TILESHEETS = "assets/images/";
	// Tilemap used for collision
	public var tilemap:FlxTilemapExt;
	public var player:Player;
	public var objects:FlxTypedGroup<FlxSprite>;
	public var birds:FlxTypedGroup<FlxSprite>;
	public var bullets:FlxTypedGroup<CanonBullet>;
	public var ld:FlxSprite;
	public var spawners = new FlxTypedGroup<Spawner>();

	public function new(tiledLevel:Dynamic)
	{
		super(tiledLevel);
		objects = new FlxTypedGroup<FlxSprite>();
		birds = new FlxTypedGroup<FlxSprite>();
		bullets = new FlxTypedGroup<CanonBullet>();
		spawners = new FlxTypedGroup<Spawner>();
		//FlxG.camera.setBounds(0, 0, fullWidth, fullHeight, true);
		// Load Tile Maps
		var tileLayer = layers[FlxRandom.intRanged(0,layers.length-1)];

		var processedPath = c_PATH_LEVEL_TILESHEETS + "tileset.png";
		tilemap = new FlxTilemapExt();
		tilemap.widthInTiles = width;
		tilemap.heightInTiles = height;

		tilemap.loadMap(tileLayer.csvData.split(",").filter(function(el) {return el != "\n";})
		, processedPath, 32, 32, 0, 1,1, 7);
		//tilemap.setTileProperties(11,FlxObject.NONE);


	}
	public function loadObjects(state:PlayState)
	{
		for (group in objectGroups)
			{
				for (o in group.objects)
					{
						loadObject(o, group, state);
					}
			}

	}
	private function loadObject(o:TiledObject, g:TiledObjectGroup, state:PlayState)
	{
		var x:Int = o.x;
		var y:Int = o.y;
		// objects in tiled are aligned bottom-left (top-left in flixel)
		if (o.gid != -1)
			y -= g.map.getGidOwner(o.gid).tileHeight;
		switch (o.type.toLowerCase())
			{
				case "playerstart":
					player = new Player(x,y);
					player.width -=10;
					player.height -= 5;
					player.centerOffsets();
					player.height -= 20;
					player.offset.y += 15;
					state.add(player);
				case "enemy":
					var enemy = new Enemy(x,y-tileWidth, this);
					enemy.width = 32;
					enemy.height = 64;
					objects.add(enemy);
					state.add(enemy);
					state.add(enemy.gibs);
				case "bird":
					var bird = new Bird(x,y);
					bird.width = 32;
					bird.height = 32;
					birds.add(bird);
					state.add(bird);
				case "canon":
					var canon = new Canon(x,y, this, bullets, player);
					canon.width = 64;
					canon.height = 32;
					objects.add(canon);
					state.add(canon);
				case "spawner":
					var spawner = new Spawner(x,y, state, objects, birds);
					spawners.add(spawner);
					state.add(spawner);

				/*case "troll":
				    var troll = new Troll(x,y, player);
				    troll.width -=16;
					troll.height -= 16;
					troll.centerOffsets();
					troll.height -= 20;
					troll.offset.y += 15;
					troll.setState(state);
				    objects.add(troll);
				    state.add(troll);*/

			}

	}
	public function collideWithLevel(obj:FlxBasic, ?notifyCallback:FlxObject->FlxObject->Void):Bool
	{
		return FlxG.collide(tilemap, obj, notifyCallback);
	}
	 public function overlapWithLevel(obj:FlxBasic, ?notifyCallback:FlxObject->FlxObject->Void):Bool
	{
		return FlxG.overlap(tilemap, obj, notifyCallback);
	}

}
