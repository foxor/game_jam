package particle
{
	import flash.display.Sprite;
	
	public class Circle extends Sprite
	{
		public function Circle()
		{
			this.graphics.beginFill(0xFF794B);
			this.graphics.drawCircle(50, 50, 30);
			this.graphics.endFill();
			super();
		}
	}
}