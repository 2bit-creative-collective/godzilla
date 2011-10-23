package glasgowmafia.godzilla.ctrl
{
	import glasgowmafia.godzilla.sys.physical.CollisionDetectionSystem;
	import ember.core.Game;

	import glasgowmafia.godzilla.sys.physical.AttackEvent;
	import glasgowmafia.godzilla.sys.physical.PhysicalSystem;

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
