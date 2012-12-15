package;

import org.flixel.FlxSprite;

class Building extends FlxSprite
{

	public function new(X:Int, Y:Int, Width:Int = 0, Height:Int = 0)
	{
		super(X, Y);

		this.width = Width;
		this.height = Height;

		this.immovable = true;

		this.makeGraphic(Width, Height, 0xFF999999);
	}
}