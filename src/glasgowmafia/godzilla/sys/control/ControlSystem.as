package glasgowmafia.godzilla.sys.control
{
	import ember.core.EntitySystem;
	import ember.core.Nodes;

	import glasgowmafia.godzilla.Tick;
	import glasgowmafia.godzilla.components.ControlComponent;
	import glasgowmafia.godzilla.model.Viewpoint;

	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	public class ControlSystem
	{

		private var _system:EntitySystem;
		private var _stage:Stage;
		private var _viewpoint:Viewpoint;

		private var _nodes:Nodes;
		private var _tick:Tick;
		
		private var _isLeft:Boolean;
		private var _isUp:Boolean;
		private var _isRight:Boolean;
		private var _isDown:Boolean;

		public function ControlSystem(system:EntitySystem, root:DisplayObjectContainer, viewpoint:Viewpoint, tick:Tick)
		{
			_system = system;
			_stage = root.stage;
			_viewpoint = viewpoint;
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
			for (var node:ControlNode = _nodes.head; node; node = node.next)
			{
				var control:ControlComponent = node.control;
				
				if (_isLeft)
					_viewpoint.dx += control.dx;
				
				if (_isRight)
					_viewpoint.dx -= control.dx;
					
				if (_isUp)
					_viewpoint.dy += control.dy;
					
				if (_isDown)
					_viewpoint.dy -= control.dy;
			}
		}

		
	}
}
