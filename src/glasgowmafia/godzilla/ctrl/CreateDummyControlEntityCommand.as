package glasgowmafia.godzilla.ctrl
{
	import ember.core.Entity;
	import ember.core.EntitySystem;

	import glasgowmafia.godzilla.components.ControlComponent;
	
	public class CreateDummyControlEntityCommand
	{
		private var _system:EntitySystem;
		
		public function CreateDummyControlEntityCommand(system:EntitySystem)
		{
			_system = system;
		}

		public function execute():void
		{
			var entity:Entity = _system.createEntity();
			
			var control:ControlComponent = new ControlComponent();
			control.velocity = 3;
			control.dAngle = Math.PI / 180;
			
			entity.addComponent(control);
		}

		
	}
}
