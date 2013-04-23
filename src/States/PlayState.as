package States
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import GameObjects.Player;
	import org.flixel.*;
	import Data.LevelData;
	import GameObjects.*;
	import Managers.*;
	
	/**
	 * ...
	 * @author josh
	 */
	public class PlayState extends FlxState
	{
		private var player:Player;
		private var levelData:LevelData = new LevelData();
		private var level:FlxTilemap;
		private var enemyManager:EnemyManager;
		[Embed(source="../../assets/graphics/tilemap.png")]
		private var tileMap:Class;
		override public function create():void
		{
			FlxG.bgColor = 0xffaaaaaa;
			
			enemyManager = new EnemyManager();
			add(enemyManager);
			
			createMap(1);
			createPlayer();
			
			//camera wil follow player
			FlxG.camera.follow(player);
		}
		
		/*
		 * create the tile map
		 */
		
		private function createMap(levelNum:int):void
		{
			switch (levelNum)
			{
				case 1:
					level = new FlxTilemap();
					level.loadMap(FlxTilemap.arrayToCSV(levelData.levelOne, 25), tileMap, 20, 20, FlxTilemap.OFF, 0, 1, 1);
					add(level);
					break;
			}
		}
		
		
		
		/*
		 * Set up the player
		 */
		private function createPlayer():void
		{
			player = new Player();
			add(player);
		}
		
		/*
		 * the enterframe function for this state, called automatically
		 */
		override public function update():void
		{
			for (var i:int = 0; i < enemyManager.enemies.length; i++) 
			{
				if (player.overlaps(enemyManager.enemies[i]))
				{
					enemyManager.enemies[i].kill();
				}
			}
		
			FlxG.collide(level, player);
			super.update();
		}
		
		/*
		 * moves the player
		 */
		/*private function movePlayer():void
		{
			
				if (FlxG.keys.UP)
				{
					player.move("up");
				}
				else if (FlxG.keys.DOWN)
				{
					player.move("down");
				}
				else
				{
					player.acceleration.y = 0
				}
				 
				if (FlxG.keys.LEFT)
				{
					player.move("left");
				}
				else if (FlxG.keys.RIGHT)
				{
					player.move("right");
				}
				else
				{
					player.acceleration.x = 0;
				}
				
		}*/
		
	
	
	}

}