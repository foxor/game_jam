package particle
{
	import flash.geom.Point;

	public class Particle extends GameObject
	{
		protected var velocity:Point;
		protected var lifeLeft:int;
		
		public function Particle(velocity:Point, lifeTime:int)
		{
			this.velocity = velocity;
			this.lifeLeft = lifeTime;
		}
		
		override public function process(dt:int):void {
			this.x += velocity.x * dt;
			this.y += velocity.y * dt;
			this.lifeLeft -= dt;
			if (this.lifeLeft < 0) {
				this.parent.removeChild(this);
			}
		}
	}
}