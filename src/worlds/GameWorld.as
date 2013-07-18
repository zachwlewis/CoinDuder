package worlds 
{
	import entities.Coin;
	import entities.CoinDuder;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * Main gameworld for the Coin Duder.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class GameWorld extends World 
	{
		protected var _coinDuder:CoinDuder;
		protected var _timeLeft:Number;
		
		protected static const MIN_SPAWN_RATE:Number = 0.5;
		protected static const MAX_SPAWN_RATE:Number = 2;
		
		public function GameWorld() 
		{
			_timeLeft = 1;
		}
		
		override public function begin():void 
		{
			// The world has begun! Call Coin Duder!
			_coinDuder = new CoinDuder();
			add(_coinDuder);
			
			super.begin();
		}
		
		override public function update():void 
		{
			updateSpawn();
			
			// Handle Duder Input.
			var xInput:int = 0;
			var yInput:int = 0;
			
			// Horizontal input
			if (Input.check(Key.LEFT)) xInput--;
			if (Input.check(Key.RIGHT)) xInput++;
			
			// Vertical input
			if (Input.check(Key.UP)) yInput--;
			if (Input.check(Key.DOWN)) yInput++;
			
			_coinDuder.x += CoinDuder.MAX_SPEED * FP.elapsed * xInput;
			_coinDuder.y += CoinDuder.MAX_SPEED * FP.elapsed * yInput;
			
			var collisionCoin:Coin = Coin(_coinDuder.collideTypes("coin", _coinDuder.x, _coinDuder.y));
			
			if (collisionCoin != null)
			{
				recycle(collisionCoin);
			}
			
			super.update();
			
		}
		
		/** Should a coin be spawned? */
		protected function updateSpawn():void
		{
			_timeLeft -= FP.elapsed;
			
			if (_timeLeft <= 0)
			{
				// Timer is done!
				create(Coin, true);
				
				// Reset timer.
				_timeLeft += FP.random * (MAX_SPAWN_RATE - MIN_SPAWN_RATE) + MIN_SPAWN_RATE;
			}
		}
		
	}

}