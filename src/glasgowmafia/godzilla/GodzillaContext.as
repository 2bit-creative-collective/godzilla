package glasgowmafia.godzilla
{
	import alecmce.random.Random;
	import alecmce.random.RandomColors;

	import ember.core.EntitySystem;

	import glasgowmafia.godzilla.ctrl.BootstrapEmberCommand;
	import glasgowmafia.godzilla.ctrl.CreateDummyGodzillaCommand;
	import glasgowmafia.godzilla.ctrl.DefineRandomWorldCommand;
	import glasgowmafia.godzilla.model.Camera;

	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;
	
	public class GodzillaContext extends Context
	{
		public function GodzillaContext(root:DisplayObjectContainer)
		{
			super(root, true);
			
			injector.mapSingleton(Random);
			injector.mapSingleton(RandomColors);
			
			injector.mapSingleton(Camera);
			injector.mapSingleton(Tick);
			injector.mapSingleton(EntitySystem);
			
			commandMap.execute(BootstrapEmberCommand);
			
			commandMap.execute(DefineRandomWorldCommand);
			commandMap.execute(CreateDummyGodzillaCommand);
		}
		
		
	}
}
