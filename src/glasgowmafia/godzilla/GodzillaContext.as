package glasgowmafia.godzilla
{
	import alecmce.random.Random;
	import alecmce.random.RandomColors;
	import ember.core.EntitySystem;
	import flash.display.DisplayObjectContainer;
	import glasgowmafia.godzilla.ctrl.BootstrapEmber;
	import glasgowmafia.godzilla.ctrl.DefineRandomWorldCommand;
	import glasgowmafia.godzilla.sys.render.RenderFactory;
	import org.robotlegs.mvcs.Context;









	public class GodzillaContext extends Context
	{
		public function GodzillaContext(root:DisplayObjectContainer)
		{
			super(root, true);
			
			injector.mapSingleton(Random);
			injector.mapSingleton(RandomColors);
			
			injector.mapSingleton(Tick);
			injector.mapSingleton(EntitySystem);
			injector.mapValue(RenderFactory, new RenderFactory(40));
			
			commandMap.execute(BootstrapEmber);
			
			commandMap.execute(DefineRandomWorldCommand);
		}
		
		
	}
}
