package glasgowmafia.godzilla.physical
{
	import ember.core.Entity;
	import ember.core.Game;
	import ember.core.Nodes;

	import glasgowmafia.godzilla.Names;
	import glasgowmafia.godzilla.components.PositionComponent;
	import glasgowmafia.godzilla.loop.GameLoopSignals;

	import org.osflash.signals.Signal;

	import flash.events.IEventDispatcher;



	public class PhysicalSystem
	{
		private var _xember:Game;
		private var _tick:Signal;
		private var _dispatcher:IEventDispatcher;
		
		private var _nodes:Nodes;
		
		private var _godzilla:Entity;
		private var _position:PositionComponent;
		
		public function PhysicalSystem(xember:Game, signals:GameLoopSignals, dispatcher:IEventDispatcher)
		{
			_xember = xember;
			_tick = signals.collisions;
			_dispatcher = dispatcher;
		}
		
		public function onRegister():void
		{
			_nodes = _xember.getNodes(PhysicalNode);
			
			_godzilla = _xember.getEntity(Names.GODZILLA);
			_position = _godzilla.getComponent(PositionComponent) as PositionComponent;
			
			_tick.add(iterate);
		}
		
		public function onRemove():void
		{
			_tick.remove(iterate);
		}
				
		private function iterate(time:uint):void
		{
			for (var node:PhysicalNode = _nodes.head as PhysicalNode; node; node = node.next)
			{
				var position:PositionComponent = node.position;
				
				if (position.rect.intersects(_position.rect))
					_dispatcher.dispatchEvent(new AttackEvent(node.entity));
			}
		}
		
	}
}
