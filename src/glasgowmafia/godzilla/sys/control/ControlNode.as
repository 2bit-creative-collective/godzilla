package glasgowmafia.godzilla.sys.control
{
	import glasgowmafia.godzilla.components.ControlComponent;
	import glasgowmafia.godzilla.components.PositionComponent;
	
	public class ControlNode
	{
		public var prev:ControlNode;
		public var next:ControlNode;
		
		[Ember(definesNode)]
		public var control:ControlComponent;
		
		[Ember(definesNode)]
		public var position:PositionComponent;
	}
}
