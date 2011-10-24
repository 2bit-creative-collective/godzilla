package glasgowmafia.godzilla.physical.ctrl
{
	import glasgowmafia.godzilla.physical.CollisionDetectionSystem;
	import ember.core.Game;

	import glasgowmafia.godzilla.physical.PhysicalSystem;

	import org.robotlegs.core.ICommandMap;
	
	public class CreateCollisionDetectionSystemCommand
	{

		private var _xember:Game;
		private var _commandMap:ICommandMap;

		public function CreateCollisionDetectionSystemCommand(xember:Game, commandMap:ICommandMap)
		{
			_xember = xember;
			_commandMap = commandMap;
			
		}
		
		public function execute():void
		{
			_xember.addSystem(CollisionDetectionSystem);
		}
		
	}
}
