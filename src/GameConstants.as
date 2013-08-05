package  
{
	/**
	 * Static source for game constants.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class GameConstants 
	{
		[Embed(source="../assets/images/fireball.png")]
		public static const FIREBALL_ART:Class;
		
		[Embed(source = "../assets/images/fireball_sprite.png")]
		public static const FIREBALL_PARTICLE:Class;
		
		[Embed(source = "../assets/images/hud_heartFull.png")]
		public static const HUD_HEART_FULL:Class;
		
		[Embed(source = "../assets/images/hud_heartEmpty.png")]
		public static const HUD_HEART_EMPTY:Class;
		
		[Embed(source = "../assets/images/coinBronze.png")]
		public static const BRONZE_COIN:Class;
		
		[Embed(source = "../assets/images/Sniglet Regular.otf", embedAsCFF = "false", fontFamily = 'snig')]
		public static const SNIGLET_FONT:Class;
		
		
	}

}