package glasgowmafia.godzilla.ctrl
{
	import glasgowmafia.godzilla.sys.render.SimpleBlitterRenderSystem;
	import ember.core.EntitySystem;

	import org.robotlegs.mvcs.Command;
	
	public class BootstrapEmber extends Command
	{
		private var _system:EntitySystem;

		public function BootstrapEmber(system:EntitySystem)
		{
			_system = system;
		}
		
		override public function execute():void
		{
			_system.addSystem(SimpleBlitterRenderSystem);
		}
		
	}
}
