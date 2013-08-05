package worlds 
{
	import entities.Coin;
	import entities.CoinDuder;
	import entities.Fireball;
	import flash.display.GradientType;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Ease;
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
		protected var _fireballEmitter:Emitter;
		
		protected var _hudCoinIcon:Image;
		protected var _hudCoinCount:Text;
		
		protected var _healthIcons:Vector.<Entity>;
		
		protected static const MIN_SPAWN_RATE:Number = 0.5;
		protected static const MAX_SPAWN_RATE:Number = 2;
		
		public function GameWorld() 
		{
			_timeLeft = 1;
			Text.font = "Snig";
		}
		
		override public function begin():void 
		{
			// Create the world.
			GameVariables.DuderHealth = 3;
			GameVariables.CoinCount = 0;
			
			// The world has begun! Call Coin Duder!
			_coinDuder = new CoinDuder();
			
			_fireballEmitter = new Emitter(GameConstants.FIREBALL_PARTICLE, 70, 70);
			_fireballEmitter.newType("trail", [0, 1, 2, 3]);
			_fireballEmitter.setMotion("trail", 0, 10, 1, 360, 10, 1, Ease.cubeOut);
			_fireballEmitter.setAlpha("trail", 0.5, 0);
			addGraphic(_fireballEmitter);
			add(_coinDuder);
			
			
			// Begin HUD setup.
			_hudCoinCount = new Text("0", 48, 10);
			_hudCoinCount.size = 24;
			_hudCoinIcon = new Image(GameConstants.BRONZE_COIN);
			_hudCoinIcon.x = -10;
			_hudCoinIcon.y = -10;
			
			// Set up healths.
			_healthIcons = new Vector.<Entity>();
			_healthIcons.push(addGraphic(new Image(GameConstants.HUD_HEART_FULL)));
			_healthIcons.push(addGraphic(new Image(GameConstants.HUD_HEART_FULL)));
			_healthIcons.push(addGraphic(new Image(GameConstants.HUD_HEART_FULL)));
			
			updateHealth();

			addGraphic(new Graphiclist(_hudCoinCount, _hudCoinIcon));
			
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
				collectCoin();
				recycle(collisionCoin);
			}
			
			var collisionFireball:Fireball = Fireball(_coinDuder.collideTypes("fireball", _coinDuder.x, _coinDuder.y));
			
			if (collisionFireball != null)
			{
				if (GameVariables.DuderHealth > 1)
				{
					GameVariables.DuderHealth--;
				}
				else
				{
					// GAME OVER, MAN.
				}
				updateHealth();
				recycle(collisionFireball);
			}
			
			super.update();
			
		}
		
		/** The player has collected a coin. */
		protected function collectCoin():void
		{
			GameVariables.CoinCount++;
			_hudCoinCount.text = GameVariables.CoinCount.toString();
		}
		
		protected function updateHealth():void
		{
			for (var i:uint = 0; i < 3; i++)
			{
				if (GameVariables.DuderHealth > i)
				{
					_healthIcons[i].graphic = new Image(GameConstants.HUD_HEART_FULL);
				}
				else
				{
					_healthIcons[i].graphic = new Image(GameConstants.HUD_HEART_EMPTY);
				}
				
				_healthIcons[i].x = FP.width - 54 * (i + 1);
				
			}
		}
		
		/** Should a coin be spawned? */
		protected function updateSpawn():void
		{
			_timeLeft -= FP.elapsed;
			
			if (_timeLeft <= 0)
			{
				// Timer is done!
				
				// Decide to create coin or fireball.
				if (FP.random < 0.25)
				{
					create(Fireball, true);
				}
				else
				{
					create(Coin, true);
				}
				
				// Reset timer.
				_timeLeft += FP.random * (MAX_SPAWN_RATE - MIN_SPAWN_RATE) + MIN_SPAWN_RATE;
			}
		}
		
		public function emitFireball(xLocation:int, yLocation:int):void
		{
			_fireballEmitter.emit("trail", xLocation, yLocation);
		}
		
	}

}