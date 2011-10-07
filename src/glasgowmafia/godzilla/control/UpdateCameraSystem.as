package glasgowmafia.godzilla.control
{
	import ember.core.EntitySystem;
	import ember.core.Nodes;

	import glasgowmafia.godzilla.components.PositionComponent;
	import glasgowmafia.godzilla.loop.GameLoopSignals;
	import glasgowmafia.godzilla.render.Camera;

	import org.osflash.signals.Signal;

	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class UpdateCameraSystem
	{
		private static const PI:Number = Math.PI;
		private static const HALF_PI:Number = Math.PI * .5;
		
		private var _system:EntitySystem;
		private var _camera:Camera;

		private var _nodes:Nodes;
		private var _tick:Signal;

		public function UpdateCameraSystem(system:EntitySystem, root:DisplayObjectContainer, camera:Camera, signals:GameLoopSignals)
		{
			_system = system;
			_camera = camera;
			_tick = signals.render;
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
		
		private function iterate(time:uint):void
		{
			var node:ControlNode = _nodes.head as ControlNode;
			var position:PositionComponent = node.position;

			var dAngle:Number = position.angle - _camera.angle;
			if (dAngle > HALF_PI)
				dAngle -= PI;
			else if (dAngle < -HALF_PI)
				dAngle += PI;
			
			if (dAngle > _camera.maxDAngle)
				dAngle = _camera.maxDAngle;
			else if (dAngle < -_camera.maxDAngle)
				dAngle = -_camera.maxDAngle;

			var rect:Rectangle = position.rect;
			var pt:Point = new Point(_camera.x - rect.x, _camera.y - rect.y);
			if (pt.length > _camera.maxDPosition)
				pt.normalize(_camera.maxDPosition);
			
			_camera.angle += dAngle;
			_camera.x -= pt.x;
			_camera.y -= pt.y;
		}
		
	}
}
