package glasgowmafia.godzilla.loop.ctrl
{
	import ember.core.Game;

	import glasgowmafia.godzilla.loop.GameLoopSignals;
	import glasgowmafia.godzilla.loop.MainGameLoopSystem;

	import org.robotlegs.core.IInjector;
	
	public class CreateMainGameLoopCommand
	{
		private var _injector:IInjector;
		private var _xember:Game;

		public function CreateMainGameLoopCommand(injector:IInjector, xember:Game)
		{
			_injector = injector;
			_xember = xember;
		}
		
		public function execute():void
		{
			_injector.mapSingleton(GameLoopSignals);
			_xember.addSystem(MainGameLoopSystem);
		}
		
	}
}
