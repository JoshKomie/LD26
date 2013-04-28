package Managers
{
	import adobe.utils.CustomActions;
	import flash.text.engine.EastAsianJustifier;
	import GameObjects.Player;
	import org.flixel.*;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author josh
	 */
	public class GuiManager extends FlxGroup
	{
		private var numRed:FlxText;
		private var numBlue:FlxText;
		private var numYellow:FlxText;
		private var player:Player;
		private var currentType:FlxText;
		public function GuiManager($player:Player)
		{
			player = $player;
			//createColorTxt(numRed, "Red", 50);
			numRed = new FlxText(50, 50, 300,  ": ");
			numRed.scrollFactor.x = 0;
			numRed.scrollFactor.y = 0;
			numBlue = new FlxText(50, 75, 300,  " :");
			numBlue.scrollFactor.x = 0;
			numBlue.scrollFactor.y = 0;
			numYellow = new FlxText(50, 100, 300,  " :");
			numYellow.scrollFactor.x = 0;
			numYellow.scrollFactor.y = 0;
			add(numRed);
			add(numBlue);
			add(numYellow);
			
			createCurrentType();
		}
		private function createColorTxt(text:FlxText, color:String, y:int):void
		{
			text = new FlxText(50, y, 300, color + ": ");
			text.scrollFactor.x = 0;
			text.scrollFactor.y = 0;
			text.size = 12;
			add(text);
		}
		
		private function updateColorTxt(text:FlxText, color:String):void
		{
			
			switch (color)
			{
				case "Red":
					text.text =  color + ": " +  player.amtRed.toString();
					break;
				case "Blue":
					text.text = color + ": " +  player.amtBlue.toString();
					break;
				case "Yellow":
					text.text = color + ": " +  player.amtYellow.toString();
					break;
			}
			
		}
		
		private function createCurrentType():void
		{
			currentType = new FlxText(50, 125, 300, "current build type:");
			currentType.scrollFactor.x = 0;
			currentType.scrollFactor.y = 0;
			currentType.size = 18;
			add(currentType);
		}
		override public function update():void
		{
			updateColorTxt(numRed, "Red");
			updateColorTxt(numBlue, "Blue");
			updateColorTxt(numYellow, "Yellow");
			
			currentType.text = "current build type: " + player.buildType;
			super.update();
		
		}
	}
}