package glasgowmafia.godzilla.ctrl
{
	import ember.core.EntitySystem;

	import glasgowmafia.godzilla.sys.control.KeyHandlerSystem;
	import glasgowmafia.godzilla.sys.control.UpdateCameraSystem;
	import glasgowmafia.godzilla.sys.render.ViewpointBlitterSystem;

	
	public class BootstrapEmberCommand
	{
		private var _system:EntitySystem;

		public function BootstrapEmberCommand(system:EntitySystem)
		{
			_system = system;
		}
		
		public function execute():void
		{
			_system.addSystem(ViewpointBlitterSystem);
			_system.addSystem(KeyHandlerSystem);
			_system.addSystem(UpdateCameraSystem);
		}
		
	}
}
