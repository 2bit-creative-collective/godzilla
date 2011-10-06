package glasgowmafia.godzilla.sys.physical
{
	import ember.core.Entity;

	import flash.events.Event;

	public class AttackEvent extends Event
	{
		public static const ATTACK_TYPE:String = "ATTACK_EVENT";
		
		public var entity:Entity;

		public function AttackEvent(entity:Entity)
		{
			super(ATTACK_TYPE);
			this.entity = entity;
		}
	}
}
