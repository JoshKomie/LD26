package GameObjects 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author josh
	 */
	public class TestObject extends FlxSprite 
	{
		
		public function TestObject() 
		{
			makeGraphic(30, 20, 0xff0000FF);
		}
		
		override public function update():void
		{
			var thisCoord:FlxPoint = new FlxPoint(x, y);
			var mouseCoord:FlxPoint = new FlxPoint(FlxG.mouse.x, FlxG.mouse.y);
			var angleDeg:int = FlxU.getAngle(mouseCoord, thisCoord);
			var distance:int = FlxU.getDistance(thisCoord, mouseCoord);
			if (distance < 100)
			{
				x = FlxG.mouse.x;
				y = FlxG.mouse.y;
			}
			else
			{
				var speed:int = 10;
				var rad:Number = Utils.rad(angleDeg);
				x += Math.cos(rad) * speed;
				y += Math.sin(rad) * speed;
			}
			
			super.update();
		}
		
	}

}