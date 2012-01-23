package battle
{
	import flash.geom.Vector3D;
	
	import game.Game;
	
	import physics.MovingBody;
	import physics.PhysicsBody;
	
	public class MechRange extends MovingBody
	{
		private var mech:Mech;
		public function MechRange(mech:Mech, range:int=200)
		{
			super(Game.COLLISION_MECH_RANGE);
			this.mech = mech;
			this.copyPoint(mech.x - range / 2, mech.y - range / 2);
			this.width = range;
			this.height = range;
		}
		
		override public function collision(target:PhysicsBody):void {
			if (target.collisionGroup == Game.COLLISION_MECHS && (target.gameObject as Mech).teamId != this.mech.teamId) {
				mech.fireAt(target.gameObject as Mech);
			}
		}
		
		public function moveTo(x:int ,y:int , z:int = 0):void {
			target = new Vector3D(x, y, z);
		}
		
		public function setPosition(x:int ,y:int , z:int = 0):void {
			position = new Vector3D(x, y, z);
		}
	}
}