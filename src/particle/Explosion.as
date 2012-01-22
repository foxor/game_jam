package particle
{
	import flash.geom.Point;
	
    import gameobjects.GameObject;
    
	public class Explosion extends GameObject
	{
		public function Explosion()
		{
			addChild(new FactoryEmitter(Circle.circleFactory(), 20, 10, null, 60, 3));
			addChild(new FactoryEmitter(Circle.circleFactory(0xFF6310, 10), 80, 10, null, 20, 4));
		}
		
		override public function process(td:int):void {
			super.process(td);
			if (Math.random() < 0.01) {
				addChild(new FactoryEmitter(Circle.circleFactory(), 20, 10, null, 40, 2));
				addChild(new FactoryEmitter(Circle.circleFactory(0xFF6310, 10), 40, 10, null, 40, 4));
			}
		}
	}
}