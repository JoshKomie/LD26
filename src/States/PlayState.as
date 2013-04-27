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
		private var guiManager:GuiManager;
		private var currentLevel:int;
		private var currentLevelArray:Array;
		private static var TILE_SIZE:int = 30;
		override public function create():void
		{
			FlxG.bgColor = 0xffaaaaaa;
			
			currentLevel = 1;
			createMap(currentLevel);
			createPlayer();
			createRandomIntArray(30, 0, 1);
			//camera wil follow player
			FlxG.camera.follow(player);
			guiManager = new GuiManager(player);
			add(guiManager);
		}
		
		/**
		 * creates an array of random integers
		 * @param	length the length of the array
		 * @param	lowestValue lowest value that will be included
		 * @param	highestValue highest value that will be included
		 * @return
		 */

		private function createRandomIntArray(length:int, lowestValue:int, highestValue:int):Array
		{
			var array:Array = new Array(length);
			
			for (var i:int = 0; i < length; i++)
			{
				array[i] = Utils.rollInt(lowestValue, highestValue);
				
			}
			return array;
		}
		
		/**
		 * add resources to the current level array by creating "pockets" of resources (currently just trees)
		 * @param	array the array that will be changed
		 */
		private function addResources(array:Array):void
		{
			var numPockets:int = Utils.rollInt(15, 20); //15 - 20 pockets of resources
			var pockets:Array = new Array(); //the index of where each pocket will be
			pockets = createRandomIntArray(numPockets, 0, 5000); //randomize where the pockes are
			
			//create the trees
			for (var i:int = 0; i < array.length; i++)
			{
				for (var j:int = 0; j < numPockets; j++)
				{
					var diff:int = Math.abs(i - pockets[j]);
					if (diff < 2)
					{
						array[i] = 3;
						array[i + 100] = 3;
						array[i - 100] = 3;
					}
				}
				
			}
		}
		
		
		/*
		 * create the tile map
		 */
		
		private function createMap(levelNum:int):void
		{
			currentLevelArray = createRandomIntArray(5000, 0, 1)
			addResources(currentLevelArray);
			switch (levelNum)
			{
				case 1:
					level = new FlxTilemap();
					level.loadMap(FlxTilemap.arrayToCSV(currentLevelArray, 100), levelData.levelOneTilemap, 30, 30, FlxTilemap.OFF, 0, 0, 4);
					add(level);
					break;
			}
		}
		
		/**
		 * takes away the green tiles and replaces it with brown, adds to player numLogs
		 */
		private function chopTree():void
		{
			var center:FlxPoint = player.getMidpoint();
			var newGround:int = Utils.rollInt(0, 1);
			level.setTile(center.x / TILE_SIZE, center.y / TILE_SIZE, newGround);
			player.numLogs++;
		}
		
		/*
		 * Set up the player
		 */
		private function createPlayer():void
		{
			player = new Player();
			player.x = 1500;
			player.y = 600;
			add(player);
		}
		
		/*
		 * the enterframe function for this state, called automatically
		 */
		override public function update():void
		{
			getTileUnder();
			//trace(player.isOver);
			if (FlxG.keys.SPACE && player.isOver == 3)
			{
				chopTree();
			}
			FlxG.collide(level, player);
			super.update();
		}
		
		public function nextLevel():void
		{
			currentLevel++;
			level.kill();
			level = new FlxTilemap();
					level.loadMap(FlxTilemap.arrayToCSV(levelData.levelTwo, 25), levelData.levelTwoTilemap, 20, 20, FlxTilemap.OFF, 0, 1, 1);
					add(level);
			
		}
		
		/**
		 * find out what type of tile the player is under
		 */
		private function getTileUnder():void
		{
			var center:FlxPoint = player.getMidpoint();// new FlxPoint(player.width / 2, player.height / 2);
			var tile:int = level.getTile(center.x / TILE_SIZE, center.y / TILE_SIZE);
			player.isOver = tile;
		}
		
	
	
	}

}