package particle
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import gameobjects.GameObject;
	import gameobjects.GameObjectManager;

	public class Particle extends GameObject
	{
		protected var sprite:Sprite;
		protected var velocity:Point;
		protected var lifeLeft:int;
		protected var inWorld:Boolean;
		
		public function Particle(sprite:Sprite)
		{
			inWorld = false;
			addChild(sprite);
		}
		
		public function setup(x:int, y:int, velocity:Point, lifeTime:int):void {
			this.velocity = velocity;
			this.lifeLeft = lifeTime;
			this.x = x;
			this.y = y;
			if (!inWorld) {
				GameObjectManager.singleton.addChild(this);
				inWorld = true;
			}
		}
		
		override public function process(dt:int):void {
			this.x += velocity.x;
			this.y += velocity.y;
			this.lifeLeft -= 1;
			if (this.lifeLeft < 0) {
				GameObjectManager.singleton.removeChild(this);
				inWorld = false;
			}
		}
		
		public static function particleFactory(color:Number=0xFF794B, radius:Number=15):Function {
			return function():Particle {
				return new Particle(new Circle(color, radius));
			}
		}
	}
}