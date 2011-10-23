package glasgowmafia.godzilla.init.ctrl
{
	import alecmce.random.Random;

	import ember.core.Entity;
	import ember.core.Game;

	import glasgowmafia.godzilla.components.PhysicalComponent;
	import glasgowmafia.godzilla.components.PositionComponent;
	import glasgowmafia.godzilla.components.RenderComponent;

	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	public class DefineRandomWorldCommand
	{
		private static const COLUMNS:int = 20;
		private static const ROWS:int = 20;
		private static const SIZE:int = 40;
		
		private var _xember:Game;
		private var _random:Random;

		public function DefineRandomWorldCommand(xember:Game, random:Random)
		{
			_xember = xember;
			_random = random;
		}

		public function execute():void
		{
			for (var x:int = 0; x < COLUMNS; x++)
			{
				for (var y:int = 0; y < ROWS; y++)
				{
					createEntity(x, y);
				}
			}
		}

		private function createEntity(x:int, y:int):void
		{
			var entity:Entity = _xember.createEntity();
			
			var isTarget:Boolean = _random.nextBoolean(.05);
			if (isTarget)
			{
				var physical:PhysicalComponent = generatePhysical(x, y);
				entity.addComponent(physical);
			}
			
			entity.addComponent(generateRender(x, y, isTarget ? 0xFF0000 : 0));
			entity.addComponent(generatePosition(x, y));
		}

		private function generatePhysical(x:int, y:int):PhysicalComponent
		{
			var physical:PhysicalComponent = new PhysicalComponent();
			physical.strength = 1;
			return physical;
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
			var position:PositionComponent = new PositionComponent();
			position.rect = new Rectangle(x * SIZE, y * SIZE, SIZE, SIZE);
			trace("rect "+position.rect.x, position.rect.y, position.rect.width, position.rect.height);
			return position;
		}
		
		
	}
}
