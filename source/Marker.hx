package;

import org.flixel.FlxSprite;
import org.flixel.FlxPoint;

class Marker extends FlxSprite
{
	public static var LEFT:Int = 0;
	public static var RIGHT:Int = 1;

	private var side:Int;

	public function new(Side:Int){
		super(0,0);

		this.scrollFactor = new FlxPoint(0,0);

		side = Side;

		if(side == LEFT){
			this.x = 2;
		}else{
			this.x = 320 - 10;
		}

		this.makeGraphic(8,16,0xFF999900);
	}

	public function disappear():Void
	{
		this.visible = false;
	}
}