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
		private var currentType:FlxText;
		public function GuiManager($player:Player)
		{
			player = $player;
			createLogsText();
			createCurrentType();
		}
		private function createLogsText():void
		{
			logs = new FlxText(50, 50, 300, "logs: 0");
			logs.scrollFactor.x = 0;
			logs.scrollFactor.y = 0;
			logs.size = 24;
			add(logs);
		}
		
		private function createCurrentType():void
		{
			currentType = new FlxText(50, 100, 300, "current build type:");
			currentType.scrollFactor.x = 0;
			currentType.scrollFactor.y = 0;
			currentType.size = 24;
			add(currentType);
		}
		override public function update():void
		{
			//trace(player.currentBuildType);	
			currentType.text = "current build type: " + player.buildType;
				logs.text = "logs: " +  player.numLogs.toString();
				super.update();
		
		}
	}
}