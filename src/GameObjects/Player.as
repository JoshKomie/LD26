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
		
		public var amtRed:int = 0; // number of logs he has
		public var amtYellow:int = 0;
		public var amtBlue:int = 0;
		
		public var currentBuildType:int = PlayState.YELLOW;
		private var currentBuildTypeIndex:int = 0;
		private var possibleBuildTypes:Vector.<int> = new Vector.<int>;
		public var buildType:String;
		public var center:FlxObject = new FlxObject();
		
		[Embed(source="../../assets/graphics/spritesheet.png")]
		private var spriteSheet:Class;
		
		public function Player(startx:int = 50, starty:int = 50)
		{
			loadGraphic(spriteSheet, true, false, 30, 30);
			x = startx;
			y = starty;
			//this.elasticity = 5;
			addAnimation("normal", [0], 0, false);
			play("normal");
			this.drag.x = 3000;
			this.drag.y = 3000;
			this.maxVelocity.x = 800;
			this.maxVelocity.y = 800;
			width = 1;
			height = 1;
			offset.x = 10;
			offset.y = 10;
			possibleBuildTypes.push(PlayState.PURPLE, PlayState.ORANGE, PlayState.GREEN);
			trace(possibleBuildTypes);
			currentBuildType = possibleBuildTypes[0];
			buildType = "press Q to cycle build types";
		}
		
		override public function update():void
		{
			
			if (FlxG.keys.justReleased("Q"))
			{
				changeBuildType();
			}
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
			bounce();
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
			switch (type)
			{
				case PlayState.PURPLE: 
					if (amtRed > 0 && amtBlue > 0 && level.getTile(x, y) != type)
					{
						level.setTile(x, y, PlayState.PURPLE);
						amtRed--;
						amtBlue--;
					}
					break;
				case PlayState.GREEN: 
					if (amtYellow > 0 && amtBlue > 0 && level.getTile(x, y) != type)
					{
						level.setTile(x, y, PlayState.GREEN);
						amtYellow--;
						amtBlue--;
					}
					break;
				case PlayState.ORANGE: 
					if (amtRed > 0 && amtYellow > 0 && level.getTile(x, y) != type)
					{
						level.setTile(x, y, PlayState.ORANGE);
						amtRed--;
						amtYellow--;
					}
					break;
				default: 
					trace("no such type");
			
			}
		}
		
		private function changeBuildType():void
		{
			currentBuildTypeIndex++;
			if (currentBuildTypeIndex >= possibleBuildTypes.length)
			{
				currentBuildTypeIndex = 0;
			}
			currentBuildType = possibleBuildTypes[currentBuildTypeIndex];
			switch (currentBuildType)
			{
				case PlayState.PURPLE: 
					buildType = "Purple";
					break;
				case PlayState.ORANGE: 
					buildType = "Orange";
					break;
				case PlayState.GREEN: 
					buildType = "Green";
					break;
			
			}
		}
	}

}