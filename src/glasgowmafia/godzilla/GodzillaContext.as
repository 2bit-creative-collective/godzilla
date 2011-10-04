package glasgowmafia.godzilla
{
	import alecmce.random.Random;
	import alecmce.random.RandomColors;

	import ember.core.EntitySystem;

	import glasgowmafia.godzilla.ctrl.BootstrapEmber;
	import glasgowmafia.godzilla.ctrl.CreateDummyControlEntityCommand;
	import glasgowmafia.godzilla.ctrl.DefineRandomWorldCommand;
	import glasgowmafia.godzilla.model.Viewpoint;
	import glasgowmafia.godzilla.sys.render.RenderFactory;

	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;
	
	public class GodzillaContext extends Context
	{
		public function GodzillaContext(root:DisplayObjectContainer)
		{
			super(root, true);
			
			injector.mapSingleton(Random);
			injector.mapSingleton(RandomColors);
			
			injector.mapSingleton(Viewpoint);
			injector.mapSingleton(Tick);
			injector.mapSingleton(EntitySystem);
			injector.mapValue(RenderFactory, new RenderFactory(40));
			
			commandMap.execute(BootstrapEmber);
			
			commandMap.execute(DefineRandomWorldCommand);
			commandMap.execute(CreateDummyControlEntityCommand);
		}
		
		
	}
}
