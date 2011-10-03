package glasgowmafia.godzilla
{
	import glasgowmafia.godzilla.ctrl.BootstrapWorldCommand;
	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;

	public class GodzillaContext extends Context
	{
		public function GodzillaContext(root:DisplayObjectContainer)
		{
			super(root, true);
			
			commandMap.execute(BootstrapWorldCommand);
		}
		
		
	}
}
