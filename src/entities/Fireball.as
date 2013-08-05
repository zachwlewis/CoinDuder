package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Particle;
	import worlds.GameWorld;
	
	/**
	 * A burning hot ball of flame.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class Fireball extends Entity 
	{		
		protected var _image:Image;
		protected var _currentSpeed:Number;
		protected var _currentSpinSpeed:Number;
		protected var _fireballTrail:Emitter;
		
		public static const MAX_SPEED:Number = 220;
		public static const SPIN_SPEED:Number = 720;
		
		public function Fireball() 
		{
			_image = new Image(GameConstants.FIREBALL_ART);
			
			_image.centerOrigin();
			_image.smooth = true;
			_currentSpeed = 0;
			
			type = "fireball";
		}
		
		override public function added():void 
		{
			addGraphic(_image);
			setHitbox(40, 40, 20, 20);
			
			if (FP.rand(2) > 0)
			{
				x = FP.width + halfWidth;
				_currentSpeed = -MAX_SPEED;
				_currentSpinSpeed = SPIN_SPEED;
				_image.flipped = true;
			}
			else
			{
				x = -halfWidth;
				_currentSpeed = MAX_SPEED;
				_currentSpinSpeed = -SPIN_SPEED;
				_image.flipped = false;
			}
			
			y = FP.rand(FP.height - height) + halfHeight;
			
			super.added();
		}
		
		override public function update():void 
		{
			x += FP.elapsed * _currentSpeed;
			_image.angle += FP.elapsed * _currentSpinSpeed;
			
			GameWorld(world).emitFireball(x - width, y - height);
			
			if ( x < -width || x > FP.width + width)
			{
				// Fireball remained undudered.
				world.recycle(this);
			}
			
			super.update();
		}
		
	}

}