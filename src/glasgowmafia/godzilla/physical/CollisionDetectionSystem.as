package glasgowmafia.godzilla.physical
{
	import glasgowmafia.godzilla.components.ControlComponent;
	import flash.geom.Rectangle;
	import ember.core.Entity;
	import ember.core.Game;
	import ember.core.Nodes;

	import glasgowmafia.godzilla.Names;
	import glasgowmafia.godzilla.components.PositionComponent;
	import glasgowmafia.godzilla.loop.GameLoopSignals;
	import org.osflash.signals.Signal;

	import flash.events.IEventDispatcher;
	
	public class CollisionDetectionSystem
	{
		private var _xember:Game;
		private var _tick:Signal;
		private var _dispatcher:IEventDispatcher;
		
		private var _nodes:Nodes;
		
		private var _godzilla:Entity;
		private var _position:PositionComponent;
		
		public function CollisionDetectionSystem(xember:Game, signals:GameLoopSignals, dispatcher:IEventDispatcher)
		{
			_xember = xember;
			_tick = signals.collisions;
			_dispatcher = dispatcher;
		}
		
		public function onRegister():void
		{
			_nodes = _xember.getNodes(PhysicalNode);
			
			_tick.add(iterate);
		}
		
		public function onRemove():void
		{
			_tick.remove(iterate);
		}
				
		private function iterate(i:uint):void
		{
			_godzilla = _xember.getEntity(Names.GODZILLA);
			_position = _godzilla.getComponent(PositionComponent) as PositionComponent;
			var control:ControlComponent = _godzilla.getComponent(ControlComponent) as ControlComponent;
			for (var node:PhysicalNode = _nodes.head as PhysicalNode; node; node = node.next)
			{
				var position:PositionComponent = node.position;
				if (position.rect.intersects(_position.rect))
				{
					var inter:Rectangle = position.rect.intersection(_position.rect);
					
					var godRect:Rectangle = _position.rect;

					var cellRect:Rectangle = position.rect;

					if((control.direction & ControlComponent.DOWN_BIT) &&
					   ((godRect.x + godRect.width) > cellRect.x && 
					    (godRect.x + godRect.width) <= (cellRect.x + cellRect.width) ||
						godRect.x >= cellRect.x && godRect.x < (cellRect.x + cellRect.width)) 
						&&
						((godRect.y + godRect.height - control.velocity) <= cellRect.y ))
		            {
		            	_position.rect.y -= inter.height;
		            	//inter = position.rect.intersection(_position.rect);
		            }

		            if((control.direction & ControlComponent.UP_BIT) &&

					   ((godRect.x + godRect.width) > cellRect.x && 
					    (godRect.x + godRect.width) <= (cellRect.x + cellRect.width) ||
						godRect.x >= cellRect.x && godRect.x < (cellRect.x + cellRect.width)) 
						&&
						((godRect.y + control.velocity) >= (cellRect.y + cellRect.height)))
		            {
		            	_position.rect.y += inter.height;
		            	//inter = position.rect.intersection(_position.rect);
		            }
		            		
					if((control.direction & ControlComponent.LEFT_BIT) &&
					   
					   ((godRect.y + godRect.height) > cellRect.y &&
						(godRect.y + godRect.height) <= (cellRect.y + cellRect.height) ||
						godRect.y >= cellRect.y && godRect.y < (cellRect.y + cellRect.height)) 
						&&
						((godRect.x + control.velocity) >= (cellRect.x + cellRect.width)))
		            {
		            	_position.rect.x += inter.width;
		            
		            	//inter = position.rect.intersection(_position.rect);
		            }

		            
		            if((control.direction & ControlComponent.RIGHT_BIT) &&
					   ((godRect.y + godRect.height) > cellRect.y &&
						(godRect.y + godRect.height) <= (cellRect.y + cellRect.height) ||
						godRect.y >= cellRect.y && godRect.y < (cellRect.y + cellRect.height)) 
						&&
						((godRect.x + godRect.width - control.velocity) <= cellRect.x + cellRect.width))
		            {
		            	_position.rect.x -= inter.width;
		            	//inter = position.rect.intersection(_position.rect);
		            }
		            
		            		
				}
			}
		}
		
	}
}
