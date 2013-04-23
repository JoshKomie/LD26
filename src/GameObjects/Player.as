package GameObjects 
{
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author josh
	 */
	public class Player extends FlxSprite 
	{
		
		public function Player() 
		{
			var green:int = 0xff00FF00;
			playerWidth = 10;
			playerHeight = 10;
			this = new FlxSprite(50, 50);
			makeGraphic(10, 10, green);
			maxVelocity.x = 300;
			maxVelocity.y = 300;
			drag.x = 300;
			drag.y = 300;
		}
		
	}

}