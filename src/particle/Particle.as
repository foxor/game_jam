package particle
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import gameobjects.GameObject;

	public class Particle extends GameObject
	{
		protected var sprite:Sprite;
		protected var velocity:Point;
		protected var lifeLeft:int;
		
		public function Particle(sprite:Sprite, velocity:Point, lifeTime:int)
		{
			addChild(sprite);
			this.velocity = velocity;
			this.lifeLeft = lifeTime;
		}
		
		override public function process(dt:int):void {
			this.x += velocity.x;
			this.y += velocity.y;
			this.lifeLeft -= 1;
			if (this.lifeLeft < 0) {
				this.parent.removeChild(this);
			}
		}
	}
}