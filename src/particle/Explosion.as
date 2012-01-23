package particle
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import gameobjects.GameObject;
    
	public class Explosion extends GameObject
	{
		private var children:int;
		
		private static var setup:Boolean = false;
		private static var emitters:Array;
		private static function init():void {
			if (setup) {
				return;
			}
			emitters = [];
			emitters.push(new FactoryEmitter(Particle.particleFactory(0xFF6310, 10), 100, 80, 10, null, 20, 4));
			emitters.push(new FactoryEmitter(Particle.particleFactory(0xCF8330, 30), 100, 40, 30, null, 60, 2));
			emitters.push(new FactoryEmitter(Particle.particleFactory(0xFF6310, 10), 100, 80, 10, null, 20, 4));
			setup = true;
		}
		
		public function Explosion()
		{
			init();
			for (children = 0; children < emitters.length; children ++) {
				addChild(emitters[children]);
			}
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject {
			super.removeChild(child);
			if (!--children && parent) {
				parent.removeChild(this);
			}
			return child;
		}
		
		override public function process(td:int):void {
			super.process(td);
		}
	}
}