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
		[Embed(source = "../../assets/graphics/spritesheet.png")]
		private var spriteSheet:Class;
		public function Player(startx:int = 50, starty:int = 50)
		{
			//var green:int = 0xff00FF00;
			//makeGraphic(10, 10, green);
			loadGraphic(spriteSheet, true, false, 32, 32);
			x = startx;
			y = starty;
			addAnimation("up", [36, 37, 38], 5, false);
			addAnimation("down", [0, 1, 2], 5, false);
			addAnimation("left", [12, 13, 14], 5, false);
			addAnimation("right", [24, 25, 26], 5, false);
		}
		
		override public function update():void
		{
			//trace(_facing);
			move();
			updateAnimations();
			super.update();
		}
		
		private function move():void
		{
			velocity.x = 0;
			velocity.y = 0;
			
			if (FlxG.keys.LEFT)
			{
				velocity.x = -power;
				facing = LEFT;
			}
			else if (FlxG.keys.RIGHT)
			{
				velocity.x = power;
				facing = RIGHT;
			}
			
			if (FlxG.keys.UP)
			{
				velocity.y = -power;
				facing = UP;
			}
			else if (FlxG.keys.DOWN)
			{
				velocity.y = power;
				facing = DOWN;
			}
			
			
		}
	
		private function updateAnimations():void
		{
			if (facing == UP && Math.abs(velocity.y) > 0)
			{
				play("up");
			}
			else if (facing == DOWN && Math.abs(velocity.y) > 0)
			{
				play("down");
			}
			if (facing == LEFT && Math.abs(velocity.x) > 0)
			{
				play("left");
			}
			else if (facing == RIGHT && Math.abs(velocity.x) > 0)
			{
				play("right");
			}
		}
	}

}