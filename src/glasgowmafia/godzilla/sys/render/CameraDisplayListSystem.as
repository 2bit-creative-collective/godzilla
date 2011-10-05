package glasgowmafia.godzilla.sys.render
{
	import ember.core.EntitySystem;
	import ember.core.Nodes;

	import glasgowmafia.godzilla.Tick;
	import glasgowmafia.godzilla.components.PositionComponent;
	import glasgowmafia.godzilla.components.RenderComponent;
	import glasgowmafia.godzilla.model.Camera;

	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.utils.Dictionary;
	
	public class CameraDisplayListSystem
	{
		private var _system:EntitySystem;
		private var _root:DisplayObjectContainer;
		private var _camera:Camera;
		private var _tick:Tick;
		
		private var _layer:Sprite;
		private var _bitmaps:Dictionary;
		
		private var _sprite:Sprite;
		private var _nodes:Nodes;
		private var _matrix:Matrix;

		public function CameraDisplayListSystem(system:EntitySystem, root:DisplayObjectContainer, camera:Camera, tick:Tick)
		{
			_system = system;
			_root = root;
			_tick = tick;
			_camera = camera;
			
			_matrix = new Matrix();
			_root.addChild(_layer = new Sprite());
			_bitmaps = new Dictionary();
		}
		
		public function onRegister():void
		{
			_sprite = new Sprite();
			_root.addChild(_sprite);
			
			_nodes = _system.getNodes(RenderNode);
			_nodes.nodeAdded.add(addNode);
			_nodes.nodeRemoved.add(removeNode);
			addAllNodes(_nodes);
			
			_tick.add(iterate);
		}

		public function onRemove():void
		{
			_tick.remove(iterate);
			_root.removeChild(_sprite);
		}
		
		private function iterate():void
		{
			for (var node:RenderNode = _nodes.head as RenderNode; node; node = node.next)
			{
				var render:RenderComponent = node.render;
				var position:PositionComponent = node.position;
				var bitmap:Bitmap = _bitmaps[node];
				
				_matrix.identity();
				_matrix.translate(render.offsetX, render.offsetY);
				_matrix.rotate(-position.angle);
				_matrix.translate(position.x - render.offsetX, position.y - render.offsetY);
				bitmap.transform.matrix = _matrix;
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
			
			_bitmaps[node] = bitmap;
			_layer.addChild(bitmap);
		}

		private function removeNode(node:RenderNode):void
		{
			var bitmap:Bitmap = _bitmaps[node];
			_layer.removeChild(bitmap);
			delete _bitmaps[node];
		}
		
	}
}
