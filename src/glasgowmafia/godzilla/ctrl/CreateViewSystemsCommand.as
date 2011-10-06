package glasgowmafia.godzilla.ctrl
{
	import ember.core.EntitySystem;

	import glasgowmafia.godzilla.model.Camera;
	import glasgowmafia.godzilla.sys.render.CameraDisplayListSystem;

	import org.robotlegs.core.IInjector;
	
	public class CreateViewSystemsCommand
	{

		private var _system:EntitySystem;
		private var _injector:IInjector;

		public function CreateViewSystemsCommand(system:EntitySystem, injector:IInjector)
		{
			_system = system;
			_injector = injector;
		}

		public function execute():void
		{
			_injector.mapValue(Camera, generateCamera());
			
//			_system.addSystem(CameraBlitterSystem);
			_system.addSystem(CameraDisplayListSystem);
		}

		private function generateCamera():Camera
		{
			var camera:Camera = new Camera();
			
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
