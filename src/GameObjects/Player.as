package GameObjects
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author josh
	 */
	public class Player extends FlxSprite
	{
		private var power:int = 150; //how much he moves
		private var jumpPow:int = 100;
		private var onGround:Boolean;
		private var grav:int = 10;
		private var yPrev:int;
		
		[Embed(source = "../../assets/graphics/spritesheet.png")]
		private var spriteSheet:Class;
		public function Player(startx:int = 50, starty:int = 50)
		{
			loadGraphic(spriteSheet, true, false, 32, 32);
			
			x = startx;
			y = starty;
			yPrev = y;
			onGround = false;
			
			addAnimation("up", [36, 37, 38], 5, false);
			addAnimation("down", [0, 1, 2], 5, false);
			addAnimation("left", [12, 13, 14], 5, false);
			addAnimation("right", [24, 25, 26], 5, false);
		}
		
		override public function update():void
		{
			move();
			fall();
			updateAnimations();
			super.update();
		}
		
		private function fall():void
		{
			velocity.y += grav;
			
			onGround = (y == yPrev); // if we collide with the ground, 
			yPrev = y;
		}
		
		private function move():void
		{
			velocity.x = 0;
			
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
			
			if (FlxG.keys.UP && onGround)
			{
				velocity.y = -jumpPow;
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