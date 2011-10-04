package glasgowmafia.godzilla.sys.target
{
	import glasgowmafia.godzilla.components.PhysicalComponent;
	import glasgowmafia.godzilla.components.PositionComponent;
	import glasgowmafia.godzilla.components.RenderComponent;
	
	public class PhysicalNode
	{
		
		public var prev:PhysicalNode;
		public var next:PhysicalNode;
		
		[Ember(definesNode)]
		public var physical:PhysicalComponent;
		
		[Ember(definesNode)]
		public var position:PositionComponent;
		
		[Ember(ignore)]
		public var render:RenderComponent;
		
	}
}
