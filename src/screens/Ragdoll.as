package screens
{
	public class Ragdoll extends Menu
	{
		public function Ragdoll(x:int=0, y:int=0, width:int=1000, height:int=1000)
		{
			super(x, y, width, height);
			fb_loader.load(this);
		}
	}
}