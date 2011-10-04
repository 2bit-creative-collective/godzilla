package glasgowmafia.godzilla.sys.render
{
	import ember.core.EntitySystem;
	import ember.core.Nodes;

	import glasgowmafia.godzilla.Tick;
	import glasgowmafia.godzilla.components.RenderComponent;
	import glasgowmafia.godzilla.model.Viewpoint;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	public class SimpleBlitterRenderSystem
	{
		
		private var _system:EntitySystem;
		private var _root:DisplayObjectContainer;
		private var _viewpoint:Viewpoint;
		private var _tick:Tick;
		
		private var _data:BitmapData;
		private var _bitmap:Bitmap;
		private var _dest:Point;

		private var _nodes:Nodes;

		public function SimpleBlitterRenderSystem(system:EntitySystem, root:DisplayObjectContainer, viewpoint:Viewpoint, tick:Tick)
		{
			_system = system;
			_root = root;
			_viewpoint = viewpoint;
			_tick = tick;
		}
		
		public function onRegister():void
		{
			_data = new BitmapData(800, 600, true, 0xFFFFFFFF);
			_dest = new Point();
			_bitmap = new Bitmap(_data);
			_root.addChild(_bitmap);
			
			_nodes = _system.getNodes(RenderNode);
			
			_tick.add(iterate);
		}
		
		public function onRemove():void
		{
			_tick.remove(iterate);
			
			_root.removeChild(_bitmap);
			_bitmap = null;
			_dest = null;
			
			_data.dispose();
			_data = null;
		}
		
		private function iterate():void
		{
			_data.lock();
			_data.fillRect(_data.rect, 0);

			var dx:Number = _viewpoint.dx;
			var dy:Number = _viewpoint.dy;
			
			for (var node:RenderNode = _nodes.head; node; node = node.next)
			{
				var render:RenderComponent = node.render;
				
				_dest.x = dx + render.x;
				_dest.y = dy + render.y;
				
				_data.copyPixels(render.data, render.rect, _dest);
			}
			
			_data.unlock();
		}
		
	}
}
