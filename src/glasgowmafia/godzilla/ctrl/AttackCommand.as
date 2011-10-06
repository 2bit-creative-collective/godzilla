package glasgowmafia.godzilla.ctrl
{
	import ember.core.Entity;

	import glasgowmafia.godzilla.components.PhysicalComponent;
	import glasgowmafia.godzilla.components.RenderComponent;
	import glasgowmafia.godzilla.sys.physical.AttackEvent;
	
	public class AttackCommand
	{
		private var _entity:Entity;
		private var _physical:PhysicalComponent;
		private var _render:RenderComponent;

		public function AttackCommand(event:AttackEvent)
		{
			_entity = event.entity;
			
			_physical = _entity.getComponent(PhysicalComponent) as PhysicalComponent;
			_render = _entity.getComponent(RenderComponent) as RenderComponent;
		}

		public function execute():void
		{
			if (_physical.strength-- > 0)
				return;
			
			_entity.removeComponent(PhysicalComponent);

			if (_render)
			{
				_render.data.fillRect(_render.rect, 0x000000);
				_render.invalidate = true;
			}
		}
		
	}
}
