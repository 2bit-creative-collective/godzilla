package glasgowmafia.godzilla.ctrl
{
	import alecmce.random.Random;

	import ember.core.Entity;
	import ember.core.EntitySystem;

	import glasgowmafia.godzilla.components.PositionComponent;
	import glasgowmafia.godzilla.components.RenderComponent;
	import glasgowmafia.godzilla.components.TargetComponent;

	import flash.display.BitmapData;

	public class DefineRandomWorldCommand
	{
		private static const SIZE:int = 40;
		
		private var _system:EntitySystem;
		private var _random:Random;

		public function DefineRandomWorldCommand(system:EntitySystem, random:Random)
		{
			_system = system;
			_random = random;
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
			var entity:Entity = _system.createEntity();
			
			var isTarget:Boolean = _random.nextBoolean(.05);
			if (isTarget)
				entity.addComponent(generateTarget(x, y));
			
			entity.addComponent(generateRender(x, y, isTarget ? 0xFF0000 : 0));
			entity.addComponent(generatePosition(x, y));
		}

		private function generateTarget(x:int, y:int):TargetComponent
		{
			var target:TargetComponent = new TargetComponent();
			return target;
		}

		private function generateRender(x:int, y:int, color:int = 0):RenderComponent
		{
			color ||= (x + y) % 2 ? 0xCCCCCC : 0x999999;
			
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
