package glasgowmafia.godzilla.ctrl
{
	import ember.core.Entity;
	import ember.core.EntitySystem;

	import glasgowmafia.godzilla.model.World;
	import glasgowmafia.godzilla.model.WorldTile;
	import glasgowmafia.godzilla.view.RenderFactory;
	
	public class DefineWorldCommand
	
	{
		private var _system:EntitySystem;
		private var _world:World;
		private var _factory:RenderFactory;

		public function DefineWorldCommand(system:EntitySystem, world:World, factory:RenderFactory)
		{
			_system = system;
			_world = world;
			_factory = factory;
		}

		public function execute():void
		{
			var columns:uint = _world.columns;
			var rows:uint = _world.rows;
			
			for (var x:int = 0; x < columns; x++)
			{
				for (var y:int = 0; y < rows; y++)
					createEntity(x, y);
			}
		}

		private function createEntity(x:int, y:int):void
		{
			var tile:WorldTile = _world.get(x, y);
			var entity:Entity = _system.createEntity();
			
			entity.addComponent(_factory.generateRender(x, y, tile));
		}
		
		
	}
}
