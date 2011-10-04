package glasgowmafia.godzilla.ctrl
{
	import alecmce.random.RandomColors;
	import ember.core.Entity;
	import ember.core.EntitySystem;
	import glasgowmafia.godzilla.sys.render.RenderFactory;

	public class DefineRandomWorldCommand
	{
		
		private var _system:EntitySystem;
		private var _factory:RenderFactory;
		private var _colors:RandomColors;

		public function DefineRandomWorldCommand(system:EntitySystem, factory:RenderFactory, colors:RandomColors)
		{
			_system = system;
			_factory = factory;
			_colors = colors;
		}

		public function execute():void
		{
			var columns:uint = 10;
			var rows:uint = 10;
			
			for (var x:int = 0; x < columns; x++)
			{
				for (var y:int = 0; y < rows; y++)
					createEntity(x, y);
			}
		}

		private function createEntity(x:int, y:int):void
		{
			var color:uint = _colors.nextColor();
			var entity:Entity = _system.createEntity();
			
			entity.addComponent(_factory.generateRender(x, y, color));
		}
		
		
	}
}
