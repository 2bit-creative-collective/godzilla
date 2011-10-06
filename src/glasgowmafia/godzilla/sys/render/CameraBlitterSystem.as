package glasgowmafia.godzilla.sys.render
{
	import ember.core.EntitySystem;
	import ember.core.Nodes;

	import glasgowmafia.godzilla.Tick;
	import glasgowmafia.godzilla.components.PositionComponent;
	import glasgowmafia.godzilla.components.RenderComponent;
	import glasgowmafia.godzilla.model.Camera;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class CameraBlitterSystem
	{
		private var _system:EntitySystem;
		private var _root:DisplayObjectContainer;
		private var _camera:Camera;
		private var _tick:Tick;
		
		private var _data:BitmapData;
		private var _interim:BitmapData;
		private var _matrix:Matrix;
		private var _bitmap:Bitmap;
		private var _dest:Point;

		private var _nodes:Nodes;

		public function CameraBlitterSystem(system:EntitySystem, root:DisplayObjectContainer, camera:Camera, tick:Tick)
		{
			_system = system;
			_root = root;
			_camera = camera;
			_tick = tick;
			
			_matrix = new Matrix();
		}
		
		public function onRegister():void
		{
			_data = new BitmapData(800, 600, true, 0xFFFFFFFF);
			_interim = new BitmapData(2000, 2000, true, 0xFFFFFFFF);
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
			
			_interim.lock();
			_interim.fillRect(_data.rect, 0);

			for (var node:RenderNode = _nodes.head; node; node = node.next)
			{
				var render:RenderComponent = node.render;
				var position:PositionComponent = node.position;
				
				var rect:Rectangle = position.rect;
				var px:Number = rect.x;
				var py:Number = rect.y;
				
				if (position.angle != 0)
				{
					_matrix.identity();
					_matrix.translate(render.offsetX, render.offsetY);
					_matrix.rotate(-position.angle);
					_matrix.translate(px - render.offsetX, py - render.offsetY);
					_interim.draw(render.data, _matrix);
				}
				else
				{
					_dest.x = rect.x;
					_dest.y = rect.y;
					_interim.copyPixels(render.data, render.rect, _dest, null, null, true);
				}
			}
			
			_interim.unlock();
			
			_matrix.identity();
			_matrix.translate(-_camera.x, -_camera.y);
			_matrix.rotate(_camera.angle);
			_matrix.translate(_camera.centerX, _camera.centerY);
			
			_data.draw(_interim, _matrix, null, null, null, true);
			_data.unlock();
		}
		
	}
}
