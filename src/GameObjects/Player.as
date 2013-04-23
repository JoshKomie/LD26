package GameObjects
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author josh
	 */
	public class Player extends FlxSprite
	{
		private var power:int = 150;
		public function Player(startx:int = 50, starty:int = 50)
		{
			var green:int = 0xff00FF00;
			makeGraphic(10, 10, green);
			x = startx;
			y = starty;
		}
		
		override public function update():void
		{
			move();
		}
		
		private function move():void
		{
			velocity.x = 0;
			velocity.y = 0;
			
			if (FlxG.keys.LEFT)
			{
				velocity.x = -power;
			}
			else if (FlxG.keys.RIGHT)
			{
				velocity.x = power;
			}
			
			if (FlxG.keys.UP)
			{
				velocity.y = -power;
			}
			else if (FlxG.keys.DOWN)
			{
				velocity.y = power;
			}
			
			super.update();
		}
	
	}

}