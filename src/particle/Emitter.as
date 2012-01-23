package particle
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import gameobjects.GameObject;
	import gameobjects.GameObjectManager;

	public class Emitter extends GameObject
	{
		protected var _myParticle:Class;
		protected var numParticles:int;
		protected var timeLeft:int;
		protected var totalTime:int;
		protected var velocity:Point;
		protected var particlesFired:int;
		protected var radius:int;
		protected var speed:int;
		
		public function Emitter(particle:Class=null, numParticles:int=20, time:int=10, velocity:Point=null, radius:int=60, speed:int=2)
		{
			if (velocity == null) {
				this.velocity = new Point(0, 0);
			}
			this._myParticle = particle;
			this.numParticles = numParticles;
			this.timeLeft = time;
			this.totalTime = time;
			this.particlesFired = 0;
			this.radius = radius;
			this.speed = speed;
		}
		
		public function get myParticle():* {
			return new _myParticle();
		}
		
		override public function process (dt:int):void {
			this.timeLeft -= 1;
			var toFire:int = (numParticles * (totalTime - timeLeft)) / totalTime - particlesFired;
			for (; toFire > 0; toFire--) {
				var newVelocity:Point = velocity.clone();
				newVelocity.x += ((Math.random() + Math.random() - 1) * radius) / speed;
				newVelocity.y += ((Math.random() + Math.random() - 1) * radius) / speed;
				myParticle.setup(parent.x, parent.y, newVelocity, radius / speed);
			}
			if (timeLeft <= 0) {
				parent.removeChild(this);
			}
		}
	}
}