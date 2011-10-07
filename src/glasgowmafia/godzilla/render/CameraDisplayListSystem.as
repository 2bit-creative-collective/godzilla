package glasgowmafia.godzilla.render
{
	import ember.core.EntitySystem;
	import ember.core.Nodes;

	import glasgowmafia.godzilla.components.PositionComponent;
	import glasgowmafia.godzilla.components.RenderComponent;
	import glasgowmafia.godzilla.loop.GameLoopSignals;

	import org.osflash.signals.Signal;

	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class CameraDisplayListSystem
	{
		private var _system:EntitySystem;
		private var _root:DisplayObjectContainer;
		private var _camera:Camera;
		private var _tick:Signal;
		
		private var _matrix:Matrix;
		private var _layer:Sprite;
		private var _nodes:Nodes;

		public function CameraDisplayListSystem(system:EntitySystem, root:DisplayObjectContainer, camera:Camera, signals:GameLoopSignals)
		{
			_system = system;
			_root = root;
			_tick = signals.render;
			_camera = camera;
			
			_matrix = new Matrix();
		}
		
		public function onRegister():void
		{
			_layer = new Sprite();
			_root.addChild(_layer);
			
			_nodes = _system.getNodes(RenderNode);
			_nodes.nodeAdded.add(addNode);
			_nodes.nodeRemoved.add(removeNode);
			addAllNodes(_nodes);
			
			_tick.add(iterate);
		}

		public function onRemove():void
		{
			_tick.remove(iterate);
			_root.removeChild(_layer);
		}
		
		private function iterate(time:uint):void
		{
			for (var node:RenderNode = _nodes.head as RenderNode; node; node = node.next)
			{
				var position:PositionComponent = node.position;
				var render:RenderComponent = node.render;
				if (!position.changed && !render.invalidate)
					continue;
				
				var bitmap:Bitmap = node.bitmap;
				var rect:Rectangle = position.rect;
				
				_matrix.identity();
				_matrix.translate(render.offsetX, render.offsetY);
				_matrix.rotate(-position.angle);
				_matrix.translate(rect.x - render.offsetX, rect.y - render.offsetY);
				bitmap.transform.matrix = _matrix;
				
				position.changed = false;
				render.invalidate = false;
			}

			_matrix.identity();
			_matrix.translate(-_camera.x, -_camera.y);
			_matrix.rotate(_camera.angle);
			_matrix.translate(_camera.centerX, _camera.centerY);			
			_layer.transform.matrix = _matrix;
		}
		
		private function addAllNodes(nodes:Nodes):void
		{
			for (var node:RenderNode = nodes.head as RenderNode; node; node = node.next)
			{
				addNode(node);
			}
		}
		
		private function addNode(node:RenderNode):void
		{
			var bitmap:Bitmap = new Bitmap();
			bitmap.bitmapData = node.render.data;
			
			node.bitmap = bitmap;
			node.render.invalidate = true;
			_layer.addChild(bitmap);
		}

		private function removeNode(node:RenderNode):void
		{
			var bitmap:Bitmap = node.bitmap;
			_layer.removeChild(bitmap);
			
			node.bitmap = null;
		}
		
	}
}
