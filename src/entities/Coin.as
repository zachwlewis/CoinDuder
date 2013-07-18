package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * A coin ripe for dudeing.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class Coin extends Entity 
	{
		[Embed(source = "../../assets/images/coinGold.png")]
		protected static const ART_COIN:Class;
		
		protected var _image:Image;
		protected var _currentSpeed:Number;
		
		public static const MAX_SPEED:Number = 180;
		
		public function Coin() 
		{
			_image = new Image(ART_COIN);
			_image.centerOrigin();
			_currentSpeed = 0;
			
			type = "coin";
		}
		
		override public function added():void 
		{
			graphic = _image;
			setHitbox(40, 40, 20, 20);
			
			if (FP.rand(2) > 0)
			{
				x = FP.width + halfWidth;
				_currentSpeed = -MAX_SPEED;
			}
			else
			{
				x = -halfWidth;
				_currentSpeed = MAX_SPEED;
			}
			
			y = FP.rand(FP.height - height) + halfHeight;
			
			super.added();
		}
		
		override public function update():void 
		{
			x += FP.elapsed * _currentSpeed;
			
			if ( x < -width || x > FP.width + width)
			{
				// Coin remained undudered.
				world.recycle(this);
			}
			
			super.update();
		}
		
	}

}