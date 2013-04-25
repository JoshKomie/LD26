package  
{
	/**
	 * ...
	 * @author josh
	 */
	public class Utils 
	{
		
		public static function rad(degrees:int):Number
		{
			return (degrees * (Math.PI / 180));
		}
		
		public static function deg(rad:Number):int
		{
			return Math.floor(rad * (180 / Math.PI));
		}
		
		public static function distance(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;
			var value:Number = (dx * dx) + (dy * dy);
			return Math.sqrt(value);
		}
		
		public static function circlesAreColliding(radius1:int, radius2:int, distance:int):Boolean
		{
			if (radius1 + radius2 >= distance)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public static function rollInt(lowest:int, highest:int):int
		{
			
			return Math.floor(lowest + Math.random() * (highest + 1 - lowest))
		}
		
		public static function updateVector(vector:Vector.<*>):void
		{
			for (var i:int = vector.length - 1; i >= 0 ; i--) 
			{
				vector[i].update();
			}
		}
		
	}

}