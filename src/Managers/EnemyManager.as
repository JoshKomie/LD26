package Managers
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import GameObjects.Player;
	import org.flixel.*;
	import States.PlayState;
	
	/**
	 * ...
	 * @author josh
	 */
	public class EnemyManager extends FlxGroup
	{
		public var enemies:Vector.<FlxSprite>;
		
		
		private var player:Player;
		private var state:PlayState;
		
		public function EnemyManager($player:Player, $playState:PlayState)
		{
			var timer:Timer = new Timer(1000, 10);
			timer.addEventListener(TimerEvent.TIMER, createEnemy);
			timer.start();
			enemies = new Vector.<FlxSprite>;
			player = $player;
			state = $playState;
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
		
		override public function update():void
		{
			for (var i:int = 0; i < enemies.length; i++)
			{
				if (player!= null)
				{
					if (player.overlaps(enemies[i]))
					{
						enemies[i].kill();
					}
				}
			}
			super.update();
		}
	
	}

}