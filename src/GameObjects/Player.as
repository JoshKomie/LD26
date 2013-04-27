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
		public var isOver:int = 0; // what type of tile he is over
		public var numLogs:int = 0; // number of logs he has
		
		[Embed(source = "../../assets/graphics/spritesheet.png")]
		private var spriteSheet:Class;
		public function Player(startx:int = 50, starty:int = 50)
		{
			loadGraphic(spriteSheet, true, false, 30, 30);
			x = startx;
			y = starty;
			addAnimation("normal", [0], 0, false);
			play("normal");
		}
		
		override public function update():void
		{
			move();
			//updateAnimations();
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