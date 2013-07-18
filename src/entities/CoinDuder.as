package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * The dudiest Coin Duder ever.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class CoinDuder extends Entity 
	{
		[Embed(source = "../../assets/images/p1_front.png")]
		protected static const ART_COINDUDER:Class;
		
		protected var _playerImage:Image;
		
		public static const MAX_SPEED:Number = 200;
		
		public function CoinDuder() 
		{
			_playerImage = new Image(ART_COINDUDER);
			type = "coinDuder";
		}
		
		override public function added():void 
		{
			super.added();
			
			graphic = _playerImage;
			setHitbox(66, 92);
			
			x = FP.halfWidth - halfWidth;
			y = FP.halfHeight - halfHeight;
		}
		
		
		
	}

}