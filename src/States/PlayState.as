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
		private var currentLevel:int;
		override public function create():void
		{
			FlxG.bgColor = 0xffaaaaaa;
			
			
			currentLevel = 1;
			createMap(currentLevel);
			createPlayer();
			enemyManager = new EnemyManager(player, this);
			add(enemyManager);
		
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
					level.loadMap(FlxTilemap.arrayToCSV(levelData.levelOne, 25), levelData.levelOneTilemap, 20, 20, FlxTilemap.OFF, 0, 1, 1);
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
<<<<<<< HEAD
			for (var i:int = 0; i < enemyManager.enemies.length; i++) 
			{
				if (player.overlaps(enemyManager.enemies[i]))
				{
					enemyManager.enemies[i].kill();
				}
			}
		
=======
			FlxG.collide(level, player);
>>>>>>> 3.2
			super.update();
			FlxG.collide(level, player);
		}
		
		public function nextLevel():void
		{
			currentLevel++;
			level.kill();
			level = new FlxTilemap();
					level.loadMap(FlxTilemap.arrayToCSV(levelData.levelTwo, 25), levelData.levelTwoTilemap, 20, 20, FlxTilemap.OFF, 0, 1, 1);
					add(level);
			
		}
		
		
	
	
	}

}