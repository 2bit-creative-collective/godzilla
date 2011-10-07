package glasgowmafia.godzilla.loop.ctrl
{
	import ember.core.EntitySystem;

	import glasgowmafia.godzilla.loop.GameLoopSignals;
	import glasgowmafia.godzilla.loop.MainGameLoopSystem;

	import org.robotlegs.core.IInjector;
	
	public class CreateMainGameLoopCommand
	{

		private var _system:EntitySystem;
		private var _injector:IInjector;

		public function CreateMainGameLoopCommand(system:EntitySystem, injector:IInjector)
		{
			_system = system;
			_injector = injector;
		}
		
		public function execute():void
		{
			_injector.mapSingleton(GameLoopSignals);
			_system.addSystem(MainGameLoopSystem);
		}
		
	}
}
