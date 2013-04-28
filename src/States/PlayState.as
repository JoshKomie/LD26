package States
{
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.utils.Timer;
	import GameObjects.Player;
	import org.flixel.*;
	import Data.LevelData;
	import GameObjects.*;
	import Managers.*;
	import flash.display.BlendMode;
	
	/**
	 * ...
	 * @author josh
	 */
	
	public class PlayState extends FlxState
	{
		private var player:Player;
		private var levelData:LevelData = new LevelData();
		private var level:FlxTilemap;
		private var buildLayer:FlxTilemap;
		private var enemyManager:EnemyManager;
		private var guiManager:GuiManager;
		private var currentLevel:int;
		private var currentLevelArray:Array;
		private var buildArray:Array;
		private var center:FlxSprite = new FlxSprite();
		private static var TILE_SIZE:int = 30;
		public static const GREY1:int = 0;
		public static const GREY2:int = 1;
		public static const GREY3:int = 2;
		public static const WATER:int = 3;
		public static const RED:int = 4;
		public static const BLUE:int = 5;
		public static const YELLOW:int = 6;
		public static const PURPLE:int = 7;
		public static const GREEN:int = 8;
		public static const ORANGE:int = 9;
		[Embed(source = "../../assets/sounds/chop.mp3")]
		private var Chop:Class;
		private var chop:Sound;
		
		override public function create():void
		{
			FlxG.bgColor = 0xffaaaaaa;
			
			chop = new Chop();
			
			currentLevel = 1;
			createMap(currentLevel);
			buildArray = createRandomIntArray(5000, 0, 0);
			buildLayer = new FlxTilemap();
			buildLayer.loadMap(FlxTilemap.arrayToCSV(buildArray, 100), levelData.levelOneTilemap, TILE_SIZE, TILE_SIZE, FlxTilemap.OFF,0, 1, 5);
			add(buildLayer);
			createPlayer();
			//camera wil follow player
			FlxG.camera.follow(player);
			guiManager = new GuiManager(player);
			add(guiManager);
			 FlxG.worldBounds = new FlxRect(0, 0, 5000, 5000);
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
		 * 
		 * @param	type type of resource to add
		 * @param	numberOfPockets
		 */
		private function addResources(type:int, numberOfPockets:int):void
		{
			var pocketCenterPoints:Vector.<FlxPoint> = new Vector.<FlxPoint>();
			for (var i:int = 0; i < numberOfPockets; i++) 
			{
				pocketCenterPoints[i] = new FlxPoint();
				pocketCenterPoints[i].x = Utils.rollInt(0, 99);
				if (pocketCenterPoints[i].x == 50)
				{
					pocketCenterPoints[i].x = 0;
				}
				if (pocketCenterPoints[i].y == 50)
				{
					pocketCenterPoints[i].y = 0;
				}
				pocketCenterPoints[i].y = Utils.rollInt(0, 49);
				level.setTile(pocketCenterPoints[i].x, pocketCenterPoints[i].y, type);
			}
			
			for (var j:int = 0; j < 100; j++) 
			{
				for (var k:int = 0; k < 50; k++) 
				{
					for (var l:int = 0; l < numberOfPockets; l++) 
					{
						var size:int = Utils.rollInt(-2, 8);
						if (Math.abs(j - pocketCenterPoints[l].x) < size && Math.abs(k - pocketCenterPoints[l].y) < size)
						{
							var roll:int = Utils.rollInt(0, Math.abs(j - pocketCenterPoints[l].x + 2));
							if (roll == 0)
							{
								level.setTile(j, k, type);
							}
							
						}
					}
				}
			}
		}
		
		
		/*
		 * create the tile map
		 */
		
		private function createMap(levelNum:int):void
		{
			
			currentLevelArray = createRandomIntArray(5000, GREY1, GREY2)
			
			switch (levelNum)
			{
				case 1:
					level = new FlxTilemap();
					level.loadMap(FlxTilemap.arrayToCSV(currentLevelArray, 100), levelData.levelOneTilemap, TILE_SIZE, TILE_SIZE, FlxTilemap.OFF, 0, 0, 5);
					add(level);
					break;
			}
			addResources(BLUE, 8);
			addResources(WATER, 15);
			addResources(RED, 8);
			addResources(YELLOW, 8);
			level.setTileProperties(RED, FlxObject.ANY, bump);
			level.setTileProperties(BLUE, FlxObject.ANY, bump);
			level.setTileProperties(YELLOW, FlxObject.ANY, bump);
			
		}
		
		/**
		 * takes away the green tiles and replaces it with brown, adds to player numLogs
		 */
		private function chopTree(color:int):void
		{
			var center:FlxPoint = player.getFrontpoint(TILE_SIZE);
			var newGround:int = Utils.rollInt(GREY1, GREY2);
			color = level.getTile(center.x / TILE_SIZE, center.y / TILE_SIZE);
			level.setTile(center.x / TILE_SIZE, center.y / TILE_SIZE, newGround);
			trace(color);
			switch (color)
			{
				case RED:
					
					player.amtRed += 1;
					break;
				case BLUE:
					player.amtBlue += 1;
					break;
				case YELLOW:
					player.amtYellow += 1;
					break
			}
		}
		
		/*
		 * Set up the player
		 */
		private function createPlayer():void
		{
			player = new Player();
			player.x = 1500;
			player.y = 600;
			player.solid = true;
			level.solid = true;
			add(player);
		}
		
		/*
		 * the enterframe function for this state, called automatically
		 */
		override public function update():void
		{
			center.x = player.getMidpoint().x;
			center.y = player.getMidpoint().y;
			center.width = 0;
			center.height = 0;
			getTileUnder();
			FlxG.collide(player, buildLayer);
			
			if (FlxG.keys.SPACE)
			{
				player.build(player.currentBuildType, player.getMidpoint().x / TILE_SIZE, player.getMidpoint().y / TILE_SIZE, buildLayer);
			}
			super.update();
			FlxG.collide(player, level, bump);
			
		}
		
		private function bump(obj1:FlxObject, obj2:FlxObject):void
		{
			//player.width = 1;
			//player.height = 1;
			if (obj1 == player || obj2 == player)
			{
				if (player.mine())
				{
					chopTree(level.getTile(center.x / TILE_SIZE, center.y / TILE_SIZE));
				}
				FlxG.play(Chop);
			}
			//player.width = 10;
			//player.height = 10;
			
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