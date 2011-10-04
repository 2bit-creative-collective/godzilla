package glasgowmafia.godzilla
{
	import org.osflash.signals.Signal;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	public class Tick extends Signal
	{
		
		public function Tick(root:DisplayObjectContainer)
		{
			root.addEventListener(Event.ENTER_FRAME, iterate);
		}

		private function iterate(event:Event):void
		{
			dispatch();
		}
	}
}
