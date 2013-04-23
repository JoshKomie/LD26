package Managers 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author josh
	 */
	public class EnemyManager extends FlxGroup 
	{
		public var enemies:Vector.<FlxSprite>;
		public function EnemyManager() 
		{
			var timer:Timer = new Timer(1000, 0);
			timer.addEventListener(TimerEvent.TIMER, createEnemy);
			timer.start();
			enemies = new Vector.<FlxSprite>;
		}
		
		private function createEnemy(e:TimerEvent):void
		{
			var enemy:FlxSprite = new FlxSprite();
			enemy.makeGraphic(10, 10, 0xffFF0000);
			enemy.x = Math.random() * Main.WIDTH;
			enemy.y = 200;
			enemies.push(enemy);
			add(enemy);
		}
		
	}

}