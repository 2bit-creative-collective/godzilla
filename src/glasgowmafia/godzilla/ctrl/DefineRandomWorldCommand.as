package glasgowmafia.godzilla.ctrl
{
	import alecmce.random.RandomColors;

	import ember.core.Entity;
	import ember.core.EntitySystem;

	import glasgowmafia.godzilla.components.PositionComponent;
	import glasgowmafia.godzilla.components.RenderComponent;

	import flash.display.BitmapData;

	public class DefineRandomWorldCommand
	{
		private static const SIZE:int = 40;
		
		private var _system:EntitySystem;
		private var _colors:RandomColors;

		public function DefineRandomWorldCommand(system:EntitySystem, colors:RandomColors)
		{
			_system = system;
			_colors = colors;
		}

		public function execute():void
		{
			var columns:uint = 50;
			var rows:uint = 50;
			
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
			
			entity.addComponent(generateRender(x, y, color));
			entity.addComponent(generatePosition(x, y));
		}

		private function generateRender(x:int, y:int, color:uint):RenderComponent
		{
			var data:BitmapData = new BitmapData(SIZE, SIZE, false, color);
			
			var render:RenderComponent = new RenderComponent();
			render.data = data;
			render.rect = data.rect;
			
			return render;
		}
		
		private function generatePosition(x:int, y:int):PositionComponent
		{
			var position : * = new PositionComponent();
			position.x = x * SIZE;
			position.y = y * SIZE;
			
			return position;
		}
		
		
	}
}
