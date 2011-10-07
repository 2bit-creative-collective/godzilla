package glasgowmafia.godzilla.loop
{
	import ember.core.EntitySystem;

	import org.osflash.signals.Signal;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	public class MainGameLoopSystem
	{
		
		private var _system:EntitySystem;
		
		private var _root:DisplayObjectContainer;
		private var _time:int;
		
		private var _ai:Signal;
		private var _user:Signal;
		private var _collisions:Signal;
		private var _render:Signal;
		
		public function MainGameLoopSystem(system:EntitySystem, root:DisplayObjectContainer, signals:GameLoopSignals)
		{
			_system = system;
			
			_root = root;
			
			_ai = signals.ai;
			_user = signals.user;
			_collisions = signals.collisions;
			_render = signals.render;
		}
		
		public function onRegister():void
		{
			_root.addEventListener(Event.ENTER_FRAME, iterate);
		}
		
		public function onRemove():void
		{
			_root.removeEventListener(Event.ENTER_FRAME, iterate);
		}
				
		private function iterate(event:Event):void
		{
			_time = getTimer();
			
			_ai.dispatch(_time);
			_user.dispatch(_time);
			_collisions.dispatch(_time);
			_render.dispatch(_time);
		}
		
		
	}
}
