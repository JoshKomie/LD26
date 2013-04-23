package  States
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author josh
	 */
	public class MenuState extends FlxState 
	{
		
		override public function create():void
		{
			FlxG.bgColor = 0x000000;
			createButtons();
		}
		
		/*
		 * Set up the menus buttons
		 */
		private function createButtons():void 
		{
			//button to play, switches to play state
			var playButton:FlxButton = new FlxButton(Main.WIDTH / 2 - 40, Main.HEIGHT / 2 - 10, "Play", switchToPlay);
			add(playButton);
			
			//options
			var options:FlxButton = new FlxButton(Main.WIDTH / 2 - 40, Main.HEIGHT / 2 - 10 + 20, "Options");
			add(options);
		
		}
		
		/*
		 * switch to play state
		 */
		private function switchToPlay():void
		{
			FlxG.switchState(new PlayState());
		}
		
	}

}