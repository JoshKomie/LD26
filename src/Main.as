package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.*;
	import States.*;
	
	/**
	 * ...
	 * @author josh
	 */
	//Set the .swf dimensions
	 [SWF(width = "500", height = "300", backgroundColor = "#000000")]
	
	//the first frame is the preloader 
	[Frame(factoryClass="Preloader")]
	public class Main extends FlxGame
	{
		public static const WIDTH:int = 500;
		public static const HEIGHT:int = 300;
		public function Main():void
		{
			//create a flixel game object. The first state is MenuState
			super(WIDTH, HEIGHT, MenuState, 1, 60, 30, true);
		
		}
	
	}

}