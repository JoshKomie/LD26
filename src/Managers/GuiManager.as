package Managers
{
	import adobe.utils.CustomActions;
	import GameObjects.Player;
	import org.flixel.*;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author josh
	 */
	public class GuiManager extends FlxGroup
	{
		private var logs:FlxText;
		private var player:Player;
		
		public function GuiManager($player:Player)
		{
			player = $player;
			logs = new FlxText(50, 50, 300, "logs: 0");
			logs.scrollFactor.x = 0;
			logs.scrollFactor.y = 0;
			logs.size = 24;
			add(logs);
		}
		
		override public function update():void
		{
			
				logs.text = "logs: "+  player.numLogs.toString();
			
			super.update();
		
		}
	}
}