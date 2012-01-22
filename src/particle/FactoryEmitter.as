package particle
{
	import flash.geom.Point;
	
	public class FactoryEmitter extends Emitter
	{
		protected var factory:Function;
		public function FactoryEmitter(factory:Function, numParticles:int=20, time:int=10, velocity:Point=null, radius:int=60, speed:int=2)
		{
			this.factory = factory;
			super(null, numParticles, time, velocity, radius, speed);
		}
		
		override public function get myParticle():* {
			return factory();
		}
	}
}