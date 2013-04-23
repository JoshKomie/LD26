package States
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import GameObjects.Player;
	import org.flixel.*;
	import Data.LevelData;
	
	/**
	 * ...
	 * @author josh
	 */
	public class PlayState extends FlxState
	{
		private var player:FlxSprite;
		private var playerWidth:int;
		private var playerHeight:int;
		private var levelData:LevelData = new LevelData();
		private var level:FlxTilemap;
		[Embed(source="../../assets/graphics/tilemap.png")]
		private var tileMap:Class;
		private var flxpath:FlxPath = new FlxPath();
		override public function create():void
		{
			FlxG.bgColor = 0xffaaaaaa;
			createPlayer();
			//var timer:Timer = new Timer(1000, 0);
		//	timer.addEventListener(TimerEvent.TIMER, createEnemy);
			//timer.start();
			
			createMap(1);
		
		}
		
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
		private function createEnemy(e:TimerEvent):void
		{
			var enemy:FlxSprite = new FlxSprite();
			enemy.makeGraphic(10, 10, 0xffFF0000);
			enemy.x = Math.random() * Main.WIDTH;
			add(enemy);
		}
		
		/*
		 * Set up the player
		 */
		private function createPlayer():void
		{
			player = new Player();
		}
		
		/*
		 * the enterframe function for this state, called automatically
		 */
		override public function update():void
		{
			player.acceleration.x = player.acceleration.y = 0;
				if (FlxG.keys.UP)
				{
					player.acceleration.y = -300;
				}
				if (FlxG.keys.DOWN)
				{
					player.acceleration.y = 300;
					player.destroy();
				}
				if (FlxG.keys.LEFT)
				{
					player.acceleration.x = -300;
				}
				if (FlxG.keys.RIGHT)
				{
					player.acceleration.x = 300;
				}
			super.update();
			FlxG.collide(level, player);
		}
		
	
	
	}

}