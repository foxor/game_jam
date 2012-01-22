package particle
{
	import flash.display.Sprite;
	
	public class Circle extends Sprite
	{
		public function Circle(color:Number=0xFF794B, radius:Number=30)
		{
			this.graphics.beginFill(color);
			this.graphics.drawCircle(radius, radius, radius);
			this.graphics.endFill();
			super();
		}
		
		public static function circleFactory(color:Number=0xFF794B, radius:Number=15):Function {
			return function():Circle {
				return new Circle(color, radius);
			}
		}
	}
}