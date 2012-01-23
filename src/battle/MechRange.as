package battle
{
	import flash.geom.Vector3D;
	
	import game.Game;
	
	import physics.PhysicsBody;
	
	public class MechRange extends PhysicsBody
	{
		private var mech:Mech;
		public function MechRange(mech:Mech, range:int=2000)
		{
			super(Game.COLLISION_MECH_RANGE);
			this.mech = mech;
			this.copyPoint(mech.x - range / 2, mech.y - range / 2);
			this.width = range;
			this.height = range;
		}
		
		override public function collision(target:PhysicsBody):void {
			if (target is Mech) {
				mech.fireAt(target as Mech);
			}
		}
	}
}