package glasgowmafia.godzilla.sys.physical
{
	import ember.core.Entity;

	import glasgowmafia.godzilla.components.PhysicalComponent;
	import glasgowmafia.godzilla.components.PositionComponent;
	
	public class PhysicalNode
	{
		public var entity:Entity;
		
		public var prev:PhysicalNode;
		public var next:PhysicalNode;
		
		[Ember(required)]
		public var physical:PhysicalComponent;
		
		[Ember(required)]
		public var position:PositionComponent;
		
	}
}
