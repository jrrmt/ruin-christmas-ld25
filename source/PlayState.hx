package;

import org.flixel.FlxG;

import org.flixel.FlxState;
import org.flixel.FlxGroup;

import org.flixel.plugin.photonstorm.FlxMath;

class PlayState extends FlxState
{
	static var MIN_WIDTH = 50;
	static var MAX_WIDTH = 400;

	static var MIN_INTERVAL = 0;
	static var MAX_INTERVAL = 50;

	static var MIN_HEIGHT = 40;
	static var MAX_HEIGHT = 300;
	static var HEIGHT_INTERVAL = 80;

	static var GENERATION_WINDOW = 640;

	var buildings:FlxGroup;
	var player:Player;

	var currentFrontier:Int;
	var lastHeight:Int;

	override public function create():Void
	{
		currentFrontier = 0;
		lastHeight = 40;

		buildings = new FlxGroup();
		player = new Player(10, 150);

		this.add(buildings);
		this.add(player);

		generateLevelUntil(2000);

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

		if(currentFrontier - player.x < GENERATION_WINDOW){
			generateLevelUntil(currentFrontier + 2000);
		}

		FlxG.collide(player, buildings);
	}

	private function checkNeedMoreBuildings():Void
	{
	}

	private function generateLevelUntil(X:Int):Void
	{
		while(currentFrontier < X){
			var newWidth:Int = FlxMath.rand(MIN_WIDTH, MAX_WIDTH);
			var newInterval:Int = FlxMath.rand(MIN_INTERVAL, MAX_INTERVAL);

			var newHeight:Int = lastHeight + FlxMath.rand(-HEIGHT_INTERVAL, HEIGHT_INTERVAL);
			while(newHeight < 40){
				newHeight = lastHeight + FlxMath.rand(-HEIGHT_INTERVAL, HEIGHT_INTERVAL);
			}

			var newBuilding = new Building(currentFrontier, 240 - newHeight, newWidth, newHeight);
			buildings.add(newBuilding);

			currentFrontier += newWidth;
			currentFrontier += newInterval;
		}

		/*for(i in 0...10){
			var newBuilding = new Building(i*50, 200 - i*20, 45, 40 + i*20);

			buildings.add(newBuilding);

			FlxG.log("Making builing at "+(i*50));
		}*/
	}
}