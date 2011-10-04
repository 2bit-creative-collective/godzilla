package glasgowmafia.godzilla.sys.render
{
	import ember.core.EntitySystem;
	import ember.core.Nodes;

	import glasgowmafia.godzilla.Tick;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;

	public class SimpleBlitterRenderSystem
	{
		
		[Inject]
		public var system:EntitySystem;
		
		[Inject]
		public var view:DisplayObjectContainer;
		
		[Inject]
		public var tick:Tick;
		
		private var _data:BitmapData;
		
		private var _dest:Point;
		
		private var _nodes:Nodes;
		private var _bitmap:Bitmap;

		public function onRegister():void
		{
			_data = new BitmapData(800, 600, true, 0xFFFFFFFF);
			_dest = new Point();
			_bitmap = new Bitmap(_data);
			view.addChild(_bitmap);
			
			_nodes = system.getNodes(RenderNode);
			
			tick.add(iterate);
		}
		
		public function onRemove():void
		{
			tick.remove(iterate);
			
			view.removeChild(_bitmap);
			_bitmap = null;
			_dest = null;
			
			_data.dispose();
			_data = null;
		}
		
		private function iterate():void
		{
			_data.lock();
			_data.fillRect(_data.rect, 0);
			
			for (var node:RenderNode = _nodes.head; node; node = node.next)
			{
				var render:RenderComponent = node.render;
				
				_dest.x = render.position.x;
				_dest.y = render.position.y;
				
				_data.copyPixels(render.data, render.rect, _dest);
			}
			
			_data.unlock();
		}
		
	}
}
