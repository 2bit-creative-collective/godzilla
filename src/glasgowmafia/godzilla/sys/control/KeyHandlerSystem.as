package glasgowmafia.godzilla.sys.control
{
	import ember.core.EntitySystem;
	import ember.core.Nodes;

	import glasgowmafia.godzilla.Tick;
	import glasgowmafia.godzilla.components.ControlComponent;
	import glasgowmafia.godzilla.components.PositionComponent;

	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	public class KeyHandlerSystem
	{

		private var _system:EntitySystem;
		private var _stage:Stage;

		private var _nodes:Nodes;
		private var _tick:Tick;
		
		private var _isLeft:Boolean;
		private var _isUp:Boolean;
		private var _isRight:Boolean;
		private var _isDown:Boolean;

		public function KeyHandlerSystem(system:EntitySystem, root:DisplayObjectContainer, tick:Tick)
		{
			_system = system;
			_stage = root.stage;
			_tick = tick;
		}
		
		public function onRegister():void
		{
			_nodes = _system.getNodes(ControlNode);
			
			_tick.add(iterate);
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		public function onRemove():void
		{
			_tick.remove(iterate);
		
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}

		private function onKeyDown(event:KeyboardEvent):void
		{
			var code:uint = event.keyCode;
			
			if (code == 37)
				_isLeft = true;
			else if (code == 38)
				_isUp = true;
			else if (code == 39)
				_isRight = true;
			else if (code == 40)
				_isDown = true;
		}

		private function onKeyUp(event:KeyboardEvent):void
		{
			var code:uint = event.keyCode;
			
			if (code == 37)
				_isLeft = false;
			else if (code == 38)
				_isUp = false;
			else if (code == 39)
				_isRight = false;
			else if (code == 40)
				_isDown = false;
		}
		
		private function iterate():void
		{
			var node:ControlNode = _nodes.head as ControlNode;
			
			var position:PositionComponent = node.position;
			var control:ControlComponent = node.control;
				
			var angle:Number = position.angle;
			
			if (_isLeft != _isRight)
			{
				if (_isLeft)
					angle += control.dAngle;
			
				if (_isRight)
					angle -= control.dAngle;
			
				position.angle = angle;
				position.changed = true;
			}
			
			if (_isUp == _isDown)
				return;
			
			if (_isUp)
			{
				position.x -= Math.sin(angle) * control.velocity;
				position.y -= Math.cos(angle) * control.velocity;
				position.changed = true;
			}
			
			if (_isDown)
			{
				position.x += Math.sin(angle) * control.velocity;
				position.y += Math.cos(angle) * control.velocity;
				position.changed = true;
			}
		}
		
	}
}
