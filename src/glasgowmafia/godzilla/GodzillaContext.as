package glasgowmafia.godzilla
{
	import ember.core.EntitySystem;

	import glasgowmafia.godzilla.ctrl.BootstrapEmber;
	import glasgowmafia.godzilla.ctrl.DefineWorldCommand;
	import glasgowmafia.godzilla.ctrl.GenerateRandomWorldCommand;
	import glasgowmafia.godzilla.view.RenderFactory;

	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;

	public class GodzillaContext extends Context
	{
		public function GodzillaContext(root:DisplayObjectContainer)
		{
			super(root, true);
			
			injector.mapSingleton(Tick);
			injector.mapSingleton(EntitySystem);
			injector.mapSingleton(RenderFactory);
			
			commandMap.execute(BootstrapEmber);
			
			commandMap.execute(GenerateRandomWorldCommand);
			commandMap.execute(DefineWorldCommand);
		}
		
		
	}
}
