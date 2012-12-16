package;

import org.flixel.FlxG;

import org.flixel.FlxState;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;
import org.flixel.FlxGroup;
import org.flixel.FlxLayer;
import org.flixel.FlxObject;

import org.flixel.plugin.photonstorm.FlxSpecialFX;
import org.flixel.plugin.photonstorm.fx.StarfieldFX;
import org.flixel.plugin.photonstorm.FlxMath;

class PlayState extends FlxState
{
	static var MIN_WIDTH = 50;
	static var MAX_WIDTH = 400;

	static var MIN_INTERVAL = 0;
	static var MAX_INTERVAL = 50;

	static var MIN_HEIGHT = 40;
	static var MAX_HEIGHT = 300;
	static var HEIGHT_INTERVAL = 50;

	static var GENERATION_WINDOW = 640;

	var starfield:StarfieldFX;

	var buildings:FlxGroup;
	var presents:FlxGroup;
	var player:Player;
	var bg:FlxLayer;
	var action:FlxLayer;

	var lastCameraPos:FlxPoint;

	var currentFrontier:Int;
	var lastHeight:Int;

	var simultaneousPresents:Int;

	override public function create():Void
	{
		currentFrontier = 0;
		lastHeight = 40;
		simultaneousPresents = 1;

		bg = new FlxLayer("Background");
		action = new FlxLayer("Action");

		addLayer(bg);
		addLayer(action);

		//this.add();
		if (FlxG.getPlugin(FlxSpecialFX) == null)
		{
   			FlxG.addPlugin(new FlxSpecialFX());
		}

		starfield = FlxSpecialFX.starfield();

		var stars:FlxSprite = starfield.create(0, 0, 320, 240, 100);

		starfield.setSpeed(1);
		starfield.setStarSpeed ( 0, 0 );
		starfield.setBackgroundColor(0xFF001133);

		stars.scrollFactor = new FlxPoint(0,0);

		bg.add(stars);
		add(stars);

		buildings = new FlxGroup();
		presents = new FlxGroup();

		player = new Player(10, 0);

		action.add(buildings);
		add(buildings);
		action.add(player);
		add(player);
		action.add(presents);
		add(presents);

		generateLevelUntil(2000);

		FlxG.camera.follow(player);

		FlxG.worldBounds.x = 0;
		FlxG.worldBounds.y = 0;

		FlxG.worldBounds.height = 240;
		FlxG.worldBounds.width = 1000000000;

		FlxG.camera.setBounds(0, -240, 100000000, 480);

		lastCameraPos = new FlxPoint(0,0);

		lastCameraPos.copyFrom(FlxG.camera.scroll);

		var p:Present = new Present(100, 10);

		presents.add(p);

		super.create();
	}

	override public function update():Void
	{
		super.update();

		if(currentFrontier - player.x < GENERATION_WINDOW){
			generateLevelUntil(currentFrontier + 2000);
		}

		FlxG.collide(player, buildings);

		//TODO - Update distance to presents indicators

		FlxG.overlap(player, presents, catchPresent);

		controlStarMovement();
	}

	private function catchPresent(player:FlxObject, present:FlxObject):Void
	{
		presents.remove(present);
		present.kill();

		generatePresent();
	}

	private function generatePresent():Void{

	}

	private function controlStarMovement():Void
	{
		var starSpeedX:Float = 0;
		var starSpeedY:Float = 0;

		if(lastCameraPos.x < FlxG.camera.scroll.x){
			starSpeedX = -0.1;
		}else if(lastCameraPos.x > FlxG.camera.scroll.x){
			starSpeedX = 0.1;
		}

		if(lastCameraPos.y < FlxG.camera.scroll.y){
			starSpeedY = -0.1;
		}else if(lastCameraPos.x > FlxG.camera.scroll.x){
			starSpeedY = 0.1;
		}
		lastCameraPos.copyFrom(FlxG.camera.scroll);

		starfield.setStarSpeed(starSpeedX, starSpeedY);
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

			lastHeight = newHeight;

			var newBuilding = new Building(currentFrontier, 240 - newHeight, newWidth, newHeight);
			buildings.add(newBuilding);

			currentFrontier += newWidth;
			currentFrontier += newInterval;
		}

	}
}