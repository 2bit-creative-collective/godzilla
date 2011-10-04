package glasgowmafia.godzilla.ctrl
{
	import ember.core.EntitySystem;

	import glasgowmafia.godzilla.sys.control.KeyHandlerSystem;
	import glasgowmafia.godzilla.sys.control.UpdateCameraSystem;
	
	public class CreateControllerSystemsCommand
	{
		private var _system:EntitySystem;

		public function CreateControllerSystemsCommand(system:EntitySystem)
		{
			_system = system;
		}
		
		public function execute():void
		{
			_system.addSystem(KeyHandlerSystem);
			_system.addSystem(UpdateCameraSystem);
		}
		
	}
}
