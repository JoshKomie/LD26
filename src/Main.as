package
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.*;
	import States.*;
	import flash.display.BlendMode;
	
	/**
	 * ...
	 * @author josh
	 */
	//Set the .swf dimensions
	 [SWF(width = "650", height = "500", backgroundColor = "#000000")]
	
	//the first frame is the preloader 
	[Frame(factoryClass="Preloader")]
	public class Main extends FlxGame
	{
		[Embed(source = "../assets/graphics/texture1.jpg")]
		private var Texture:Class;
		
		public static const WIDTH:int = 650;
		public static const HEIGHT:int = 500;
		private var texture:DisplayObject;
		
		public function Main():void
		{
			//create a flixel game object. The first state is MenuState
			super(WIDTH, HEIGHT, MenuState, 1, 60, 30, true);
			
			//i want to lay the texture over everything and set its blending mode (ie transparency)
			texture = new Texture();
			//FlxG.stage.addChild(texture);
			texture.blendMode = BlendMode.MULTIPLY;
		}
	
	}

}