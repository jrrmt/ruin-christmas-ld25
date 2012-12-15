package;

import org.flixel.FlxG;

import org.flixel.FlxSprite;
import org.flixel.FlxObject;

import org.flixel.plugin.photonstorm.FlxControl;
import org.flixel.plugin.photonstorm.FlxControlHandler;

class Player extends FlxSprite
{
	public function new(X:Int, Y:Int)
	{
		super(X, Y);

		FlxG.addPlugin(new FlxControl());

		FlxControl.create(this, FlxControlHandler.MOVEMENT_ACCELERATES, FlxControlHandler.STOPPING_DECELERATES, 1, true, false);
		FlxControl.player1.setCursorControl(false, false, true, true);

		FlxControl.player1.setJumpButton("UP", FlxControlHandler.KEYMODE_PRESSED, 200, FlxObject.FLOOR, 250, 200);
		FlxControl.player1.setMovementSpeed(800, 0, 200, 200, 400, 0);
		FlxControl.player1.setGravity(0, 400);
	}
}