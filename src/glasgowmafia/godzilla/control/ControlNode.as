package glasgowmafia.godzilla.control
{
	import glasgowmafia.godzilla.components.ControlComponent;
	import glasgowmafia.godzilla.components.PositionComponent;
	
	public class ControlNode
	{
		public var prev:ControlNode;
		public var next:ControlNode;
		
		[Ember(required)]
		public var control:ControlComponent;
		
		[Ember(required)]
		public var position:PositionComponent;
		
	}
}
