package glasgowmafia.godzilla.sys.control
{
	import glasgowmafia.godzilla.components.ControlComponent;
	import glasgowmafia.godzilla.components.PositionComponent;
	
	public class ControlNode
	{
		public var prev:ControlNode;
		public var next:ControlNode;
		
		public var control:ControlComponent;
		public var position:PositionComponent;
	}
}
