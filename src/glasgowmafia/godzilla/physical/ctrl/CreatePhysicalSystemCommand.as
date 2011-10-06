package glasgowmafia.godzilla.physical.ctrl
{
	import glasgowmafia.godzilla.physical.AttackEvent;
	import glasgowmafia.godzilla.physical.PhysicalSystem;
	import org.robotlegs.core.ICommandMap;
	import ember.core.Game;


	
	public class CreatePhysicalSystemCommand
	{

		private var _xember:Game;
		private var _commandMap:ICommandMap;

		public function CreatePhysicalSystemCommand(xember:Game, commandMap:ICommandMap)
		{
			_xember = xember;
			_commandMap = commandMap;
			
		}
		
		public function execute():void
		{
			_xember.addSystem(PhysicalSystem);
			_commandMap.mapEvent(AttackEvent.ATTACK_TYPE, AttackCommand);
		}
		
	}
}
