package glasgowmafia.godzilla
{
	import alecmce.random.Random;
	import ember.core.EntitySystem;
	import flash.display.DisplayObjectContainer;
	import glasgowmafia.godzilla.control.ctrl.CreateControllerSystemsCommand;
	import glasgowmafia.godzilla.init.ctrl.CreateDummyGodzillaCommand;
	import glasgowmafia.godzilla.init.ctrl.DefineRandomWorldCommand;
	import glasgowmafia.godzilla.loop.Tick;
	import glasgowmafia.godzilla.physical.ctrl.CreatePhysicalSystemCommand;
	import glasgowmafia.godzilla.render.ctrl.CreateViewSystemsCommand;
	import org.robotlegs.mvcs.Context;
	
	public class GodzillaContext extends Context
	{
		public function GodzillaContext(root:DisplayObjectContainer)
		{
			super(root, true);
			
			injector.mapValue(Random, new Random(4));
			
			injector.mapSingleton(Tick);
			injector.mapSingleton(EntitySystem);
			
			commandMap.execute(DefineRandomWorldCommand);
			commandMap.execute(CreateDummyGodzillaCommand);
			
			commandMap.execute(CreateViewSystemsCommand);
			commandMap.execute(CreatePhysicalSystemCommand);
			commandMap.execute(CreateControllerSystemsCommand);
		}
		
		
	}
}
