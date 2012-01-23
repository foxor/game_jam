package battle
{
	import physics.PhysicsBody;
	
	public class MechRange extends PhysicsBody
	{
		private var mech:Mech;
		public function MechRange(mech:Mech, collisionGroup:int=0)
		{
			this.mech = mech;
			super(collisionGroup);
		}
		
		override public function collision(target:PhysicsBody):void {
			if (target is Mech) {
				mech.fireAt(target as Mech);
			}
		}
	}
}