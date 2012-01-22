package particle
{
	import flash.display.Sprite;
	import flash.geom.Point;

	public class Emitter extends GameObject
	{
		protected var particle:Sprite;
		protected var numParticles:int;
		protected var timeLeft:int;
		protected var totalTime:int;
		protected var velocity:Point;
		protected var particlesFired:int;
		protected var radius:int;
		protected var speed:int;
		
		public function Emitter(particle:Sprite, numParticles:int=20, time:int=10, velocity:Point=null, radius:int=10, speed:int=2)
		{
			if (velocity == null) {
				velocity = new Point(0, 0);
			}
			this.particle = particle;
			this.numParticles = numParticles;
			this.timeLeft = time;
			this.totalTime = time;
			this.particlesFired = 0;
			this.radius = radius;
			this.speed = speed;
		}
		
		override public function process (dt:int):void {
			this.timeLeft -= dt;
			var toFire = (numParticles * (totalTime - timeLeft)) - particlesFired;
			for (; toFire > 0; toFire--) {
				var newVelocity:Point = velocity.clone();
				newVelocity.x += ((Math.random() * 2 - 1) * radius) / speed;
				newVelocity.y += ((Math.random() * 2 - 1) * radius) / speed;
				parent.addChild(new Particle(newVelocity, radius / speed));
			}
			if (timeLeft <= 0) {
				parent.removeChild(this);
			}
		}
	}
}