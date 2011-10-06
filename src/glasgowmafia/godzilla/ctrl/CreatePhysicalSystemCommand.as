package glasgowmafia.godzilla.ctrl
{
	import ember.core.EntitySystem;

	import glasgowmafia.godzilla.sys.physical.AttackEvent;
	import glasgowmafia.godzilla.sys.physical.PhysicalSystem;

	import org.robotlegs.core.ICommandMap;
	
	public class CreatePhysicalSystemCommand
	{

		private var _system:EntitySystem;
		private var _commandMap:ICommandMap;

		public function CreatePhysicalSystemCommand(system:EntitySystem, commandMap:ICommandMap)
		{
			_system = system;
			_commandMap = commandMap;
			
		}
		
		public function execute():void
		{
			_system.addSystem(PhysicalSystem);
			_commandMap.mapEvent(AttackEvent.ATTACK_TYPE, AttackCommand);
		}
		
	}
}
