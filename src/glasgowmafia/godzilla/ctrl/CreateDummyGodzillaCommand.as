package glasgowmafia.godzilla.ctrl
{
	import ember.core.Entity;
	import ember.core.EntitySystem;

	import glasgowmafia.godzilla.components.ControlComponent;
	import glasgowmafia.godzilla.components.PositionComponent;
	import glasgowmafia.godzilla.components.RenderComponent;

	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class CreateDummyGodzillaCommand
	{
		private var _system:EntitySystem;

		public function CreateDummyGodzillaCommand(system:EntitySystem)
		{
			_system = system;
		}

		public function execute():void
		{
			var entity:Entity = _system.createEntity();
			
			entity.addComponent(generateRender());
			entity.addComponent(generatePosition());
			entity.addComponent(generateControl());
		}

		private function generateRender():RenderComponent
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.lineStyle(2, 0x1E90FF);
			sprite.graphics.beginFill(0xFFFFFF);
			sprite.graphics.drawCircle(20, 20, 18);
			sprite.graphics.endFill();
			sprite.graphics.moveTo(20, 20);
			sprite.graphics.lineTo(20, 2);

			var data:BitmapData = new BitmapData(40, 40, true, 0);
			data.draw(sprite);

			var render:RenderComponent = new RenderComponent();
			render.data = data;
			render.rect = data.rect;
			render.offsetX = -20;
			render.offsetY = -20;
			
			return render;
		}
		
		private function generatePosition():PositionComponent
		{
			var position:PositionComponent = new PositionComponent();
			position.x = 500;
			position.y = 500;
			
			return position;
		}
		
		private function generateControl():ControlComponent
		{
			var control:ControlComponent = new ControlComponent();
			control.velocity = 8;
			control.dAngle = 2 * Math.PI / 180;
			
			return control;
		}
				
	}
}
