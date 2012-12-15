package;

import org.flixel.FlxG;

import org.flixel.FlxState;
import org.flixel.FlxGroup;

class PlayState extends FlxState
{
	static var MIN_WIDTH = 100;
	static var MAX_WIDTH = 600;

	static var MIN_INTERVAL = 0;
	static var MAX_INTERVAL = 50;

	static var MIN_HEIGHT = 40;
	static var MAX_HEIGHT = 300;

	static var GENERATION_WINDOW = 640;

	var buildings:FlxGroup;
	var player:Player;

	var currentFrontier:Int;

	override public function create():Void
	{
		buildings = new FlxGroup();
		player = new Player(10, 120);

		this.add(buildings);
		this.add(player);

		generateInitialLevel();

		FlxG.camera.follow(player);

		FlxG.worldBounds.x = 0;
		FlxG.worldBounds.y = 0;

		FlxG.worldBounds.height = 240;
		FlxG.worldBounds.width = 1000000000;

		FlxG.camera.setBounds(0, -240, 100000000, 480);

		super.create();
	}

	override public function update():Void
	{
		super.update();

		checkNeedMoreBuildings();

		FlxG.collide(player, buildings);
	}

	private function checkNeedMoreBuildings():Void
	{
	}

	private function generateInitialLevel():Void
	{
		for(i in 0...10){
			var newBuilding = new Building(i*50, 200 - i*20, 45, 40 + i*20);

			buildings.add(newBuilding);

			FlxG.log("Making builing at "+(i*50));
		}
	}
}