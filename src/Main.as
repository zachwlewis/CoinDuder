package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import worlds.GameWorld;
	
	[SWF(width="640", height="480")]
	
	/**
	 * Entry point for Coin Duder.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class Main extends Engine 
	{
		
		public function Main():void 
		{
			super(640, 480);
		}
		
		override public function init():void 
		{
			super.init();
			FP.world = new GameWorld();
			//FP.console.enable();
		}
	}
	
}