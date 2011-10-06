package glasgowmafia.godzilla.init.ctrl
{
    import ember.core.Entity;
    import ember.core.Game;

    import glasgowmafia.godzilla.Names;
    import glasgowmafia.godzilla.components.CameraComponent;
    import glasgowmafia.godzilla.components.ControlComponent;
    import glasgowmafia.godzilla.components.PositionComponent;
    import glasgowmafia.godzilla.components.RenderComponent;

    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.geom.Rectangle;

    public class CreateDummyGodzillaCommand
    {
        private var _xember:Game;

        public function CreateDummyGodzillaCommand(xember:Game)
        {
            _xember = xember;
        }

        public function execute():void
        {
        	var entity:Entity = _xember.createEntity(Names.GODZILLA);

			entity.addComponent(generateRender());
			entity.addComponent(generatePosition());
			entity.addComponent(generateControl());
			entity.addComponent(generateCamera());
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
			position.rect = new Rectangle(20, 20, 10, 10);

			return position;
		}

		private function generateControl():ControlComponent
		{
			var control:ControlComponent = new ControlComponent();
			control.velocity = 8;
			control.dAngle = 2 * Math.PI / 180;

			return control;
		}

        private function generateCamera():CameraComponent
        {
            var camera:CameraComponent = new CameraComponent();

            camera.centerX = 400;
            camera.centerY = 500;
            camera.maxDAngle = 1.5 * Math.PI / 180;
            camera.maxDPosition = 5;

            camera.x = 0;
            camera.y = 0;
            camera.angle = 0;

            return camera;
        }
	}
}
