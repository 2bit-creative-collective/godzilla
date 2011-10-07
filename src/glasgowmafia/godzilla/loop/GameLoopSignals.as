package glasgowmafia.godzilla.loop
{
	import org.osflash.signals.Signal;
	
	public class GameLoopSignals
	{
		public var ai:Signal;
		public var user:Signal;
		public var collisions:Signal;
		public var render:Signal;
		
		public function GameLoopSignals()
		{
			ai = new Signal(uint);
			user = new Signal(uint);
			collisions = new Signal(uint);
			render = new Signal(uint);
		}

		
	}
}
