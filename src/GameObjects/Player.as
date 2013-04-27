package GameObjects
{
	import org.flixel.*;
	import States.*;
	
	/**
	 * ...
	 * @author josh
	 */
	public class Player extends FlxSprite
	{
		private var power:int = 150; //how much he moves
		private var maxPow:int = 150;
		private var mineCount:int = 0;
		public var isOver:int = 0; // what type of tile he is over
		public var numLogs:int = 0; // number of logs he has
		public var numStones:int = 0;
		
		[Embed(source = "../../assets/graphics/spritesheet.png")]
		private var spriteSheet:Class;
		public function Player(startx:int = 50, starty:int = 50)
		{
			loadGraphic(spriteSheet, true, false, 30, 30);
			x = startx;
			y = starty;
			this.elasticity = 5;
			addAnimation("normal", [0], 0, false);
			play("normal");
			this.drag.x = 2000;
			this.drag.y = 2000;
			this.maxVelocity.x = 1000;
			this.maxVelocity.y = 1000;
			width = 0;
			height = 0;
			offset.x = 15;
			offset.y = 15;
		}
		
		override public function update():void
		{
			if (isOver == 3)
			{
				drag.x = 300;
				drag.y = 300;
				power = 10;
				maxVelocity.x = 200;
				maxVelocity.y = 200;
			}
			else
			{
				drag.x = 2000;
				drag.y = 2000;
				power = 150;
				
				maxVelocity.x = 1000;
				maxVelocity.y = 1000;
			}
			move();
			
			//updateAnimations();
				
			super.update();
		}
		
		private function move():void
		{	
			if (FlxG.keys.LEFT)
			{
				if (velocity.x > -maxPow)
					velocity.x += -power;
				facing = LEFT;
				this.angle = -90;
			}
			else if (FlxG.keys.RIGHT)
			{
				if (velocity.x < maxPow)
					velocity.x += power;
				facing = RIGHT;
				this.angle = 90;
			}
			
			if (FlxG.keys.UP)
			{
				if (velocity.y > -maxPow)
					velocity.y += -power;
				facing = UP;
				this.angle = 0;
			}
			else if (FlxG.keys.DOWN)
			{
				if (velocity.y < maxPow)
					velocity.y += power;
				facing = DOWN;
				this.angle = 180;
			}
			
		}
		
		public function getFrontpoint(dist:int):FlxPoint
		{
			var p:FlxPoint = getMidpoint();
			var n:FlxPoint = frontNormal();
			n.x *= dist;
			n.y *= dist;
			
			p.x += n.x;
			p.y += n.y;
			
			return p;
		}
		
		public function frontNormal():FlxPoint
		{			
			var p:FlxPoint = new FlxPoint;
			p.x = 0;
			p.y = 0;

			switch (facing)
			{
				case UP:
					p.y = -1;
					break;
				case DOWN:
					p.y = 1;
					break;
				case LEFT:
					p.x = -1;
					break;
				case RIGHT:
					p.x = 1;
					break;
			}
			
			return p;
		}
		
		public function bounce():void
		{
			switch (facing)
			{
				case UP:
					velocity.y = 1000;
					break;
				case DOWN:
					velocity.y = -1000;
					break;
				case LEFT:
					velocity.x = 1000;
					break;
				case RIGHT:
					velocity.x = -1000;
					break;
			}
		}
		
		public function mine():Boolean
		{
			if (++mineCount >= 3)
			{
				mineCount = 0;
				return true;
			}
			
			return false;
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
		
		public function build(type:int, x:int, y:int, level:FlxTilemap):void
		{
			//if 
		}
	}

}