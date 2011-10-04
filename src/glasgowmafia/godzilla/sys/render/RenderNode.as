package glasgowmafia.godzilla.sys.render
{
	import glasgowmafia.godzilla.components.PositionComponent;
	import glasgowmafia.godzilla.components.RenderComponent;
	
	public class RenderNode
	{
		
		public var prev:RenderNode;
		public var next:RenderNode;
		
		public var render:RenderComponent;
		public var position:PositionComponent;
	}
}
