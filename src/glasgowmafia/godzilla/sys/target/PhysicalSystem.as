package glasgowmafia.godzilla.sys.target
{
	import ember.core.Entity;
	import ember.core.EntitySystem;
	import ember.core.Nodes;
	import glasgowmafia.godzilla.Names;
	import glasgowmafia.godzilla.Tick;
	import glasgowmafia.godzilla.components.PhysicalComponent;
	import glasgowmafia.godzilla.components.PositionComponent;
	import glasgowmafia.godzilla.components.RenderComponent;
	import glasgowmafia.godzilla.sys.render.RenderNode;
	
	public class PhysicalSystem
	{
		private var _system:EntitySystem;
		private var _tick:Tick;
		
		private var _nodes:Nodes;
		private var _godzilla:Entity;

		public function PhysicalSystem(system:EntitySystem, tick:Tick)
		{
			_system = system;
			_tick = tick;
		}
		
		public function onRegister():void
		{
			_nodes = _system.getNodes(RenderNode);
			_godzilla = _system.getEntity(Names.GODZILLA);
			
			_tick.add(iterate);
		}

		public function onRemove():void
		{
			_tick.remove(iterate);
		}
				
		private function iterate():void
		{
			for (var node:PhysicalNode = _nodes.head as PhysicalNode; node; node = node.next)
			{
				var physical:PhysicalComponent = node.physical;
				var position:PositionComponent = node.position;
				var render:RenderComponent = node.render;
				
				
					
			}
		}
		
	}
}
