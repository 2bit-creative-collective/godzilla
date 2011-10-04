package glasgowmafia.godzilla.sys.control
{
	import ember.core.EntitySystem;
	import ember.core.Nodes;

	import glasgowmafia.godzilla.Tick;
	import glasgowmafia.godzilla.components.PositionComponent;
	import glasgowmafia.godzilla.model.Camera;

	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;

	public class UpdateCameraSystem
	{
		private static const PI:Number = Math.PI;
		private static const TWO_PI:Number = Math.PI;
		
		private var _system:EntitySystem;
		private var _camera:Camera;

		private var _nodes:Nodes;
		private var _tick:Tick;

		public function UpdateCameraSystem(system:EntitySystem, root:DisplayObjectContainer, viewpoint:Camera, tick:Tick)
		{
			_system = system;
			_camera = viewpoint;
			_tick = tick;
		}
		
		public function onRegister():void
		{
			_nodes = _system.getNodes(ControlNode);
			_tick.add(iterate);
		}
		
		public function onRemove():void
		{
			_tick.remove(iterate);
		}
		
		private function iterate():void
		{
			var node:ControlNode = _nodes.head as ControlNode;
			var position:PositionComponent = node.position;

			var dAngle:Number = _camera.angle - position.angle;
			if (dAngle > PI)
				dAngle -= TWO_PI;
			
			dAngle *= dAngle;
			if (dAngle > _camera.maxDAngle)
				dAngle = _camera.maxDAngle;
			else if (dAngle < -_camera.maxDAngle)
				dAngle = -_camera.maxDAngle;
			
			var pt:Point = new Point(_camera.x - position.x, _camera.y - position.y);
			
			trace(_camera.x, _camera.y, position.x, position.y);
			
			if (pt.length > _camera.maxDPosition)
				pt.normalize(_camera.maxDPosition);
			
			_camera.angle += dAngle;
			_camera.x -= pt.x;
			_camera.y -= pt.y;
		}
		
	}
}
