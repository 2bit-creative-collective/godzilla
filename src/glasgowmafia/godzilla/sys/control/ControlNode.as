package glasgowmafia.godzilla.sys.control
{
	import glasgowmafia.godzilla.components.ControlComponent;
	
	public class ControlNode
	{
		public var prev:ControlNode;
		public var next:ControlNode;
		
		public var control:ControlComponent;
	}
}
