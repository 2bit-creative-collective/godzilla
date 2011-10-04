package glasgowmafia.godzilla.ctrl
{
	import alecmce.random.Random;
	import alecmce.random.RandomColors;

	import glasgowmafia.godzilla.model.World;
	import glasgowmafia.godzilla.model.WorldTile;

	import org.robotlegs.mvcs.Command;

	public class GenerateRandomWorldCommand extends Command
	{
		private var colors:RandomColors;
		
		public function GenerateRandomWorldCommand()
		{
			var random:Random = new Random();
			colors = new RandomColors(random);
		}

		override public function execute():void
		{
			var model:World = new World(40, 10, 10);
			
			for (var x:int = 0; x < 10; x++)
			{
				for (var y:int = 0; y < 10; y++)
					model.set(x, y, generateRandomAttributes());
			}
			
			injector.mapValue(World, model);
		}

		private function generateRandomAttributes():WorldTile
		{
			return new WorldTile(colors.nextColor());
		}
		
	}
}
