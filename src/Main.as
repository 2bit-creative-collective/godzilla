package 
{
	import glasgowmafia.godzilla.GodzillaContext;

	import flash.display.Sprite;

	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="800", height="600")]
	public class Main extends Sprite
	{
		private var context:GodzillaContext;
		
		public function Main()
		{
			context = new GodzillaContext(this);
		}
	}
}
