package;

import org.flixel.FlxG;

import org.flixel.FlxSprite;

class Present extends FlxSprite
{
	static var startingAltitude:Int = 50;

	private var speed:Float;

	public function new(X:Int, Speed:Float)
	{
		super(X, startingAltitude);

		speed = Speed;

		this.velocity.y = speed;

		//TODO - Randomize color and make cross "wrapping"

		this.makeGraphic(16, 16, 0xFFEE0000);
	}
}