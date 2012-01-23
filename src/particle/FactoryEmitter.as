package particle
{
	import flash.geom.Point;
	
	public class FactoryEmitter extends Emitter
	{
		protected var cacheIndex:int = 0;
		protected var cache:Array;
	
		public function FactoryEmitter(factory:Function, cache:int, numParticles:int=20, time:int=10, velocity:Point=null, radius:int=60, speed:int=2)
		{
			this.cache = new Array(cache);
			for (cache = this.cache.length - 1; cache >= 0; cache --) {
				this.cache[cache] = factory();
			}
			super(null, numParticles, time, velocity, radius, speed);
		}
		
		override public function get myParticle():* {
			return cache[cacheIndex++ % cache.length];
		}
	}
}