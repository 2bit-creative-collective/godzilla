package glasgowmafia.godzilla.control.ctrl
{
	import ember.core.Game;

	import glasgowmafia.godzilla.control.KeyHandlerSystem;
	import glasgowmafia.godzilla.control.UpdateCameraSystem;

	
	public class CreateControllerSystemsCommand
	{
		private var _xember:Game;

		public function CreateControllerSystemsCommand(xember:Game)
		{
			_xember = xember;
		}
		
		public function execute():void
		{
			_xember.addSystem(KeyHandlerSystem);
			_xember.addSystem(UpdateCameraSystem);
		}
		
	}
}
