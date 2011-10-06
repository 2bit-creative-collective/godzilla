package glasgowmafia.godzilla.render
{
	import glasgowmafia.godzilla.components.PositionComponent;
	import glasgowmafia.godzilla.components.RenderComponent;

	import flash.display.Bitmap;
	
	public class RenderNode
	{
		
		public var prev:RenderNode;
		public var next:RenderNode;
		
		[Ember(required)]
		public var render:RenderComponent;
		
		[Ember(required)]
		public var position:PositionComponent;
		
//		[Ember(ignored)]
		public var bitmap:Bitmap;
		
	}
}
