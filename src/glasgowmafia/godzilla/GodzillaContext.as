package glasgowmafia.godzilla
{
	import glasgowmafia.godzilla.ctrl.CreateViewSystemsCommand;
	import alecmce.random.Random;
	import alecmce.random.RandomColors;

	import ember.core.EntitySystem;

	import glasgowmafia.godzilla.ctrl.CreateControllerSystemsCommand;
	import glasgowmafia.godzilla.ctrl.CreateDummyGodzillaCommand;
	import glasgowmafia.godzilla.ctrl.DefineRandomWorldCommand;

	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;
	
	public class GodzillaContext extends Context
	{
		public function GodzillaContext(root:DisplayObjectContainer)
		{
			super(root, true);
			
			injector.mapSingleton(Random);
			injector.mapSingleton(RandomColors);
			
			injector.mapSingleton(Tick);
			injector.mapSingleton(EntitySystem);
			
			commandMap.execute(CreateViewSystemsCommand);
			commandMap.execute(CreateControllerSystemsCommand);
			
			commandMap.execute(DefineRandomWorldCommand);
			commandMap.execute(CreateDummyGodzillaCommand);
		}
		
		
	}
}
