package screens
{
	public class Loadout extends LayoutMenu
	{
		public function Loadout(title:String="Loadout Menu")
		{
			super();
			buildTitle(title);
			
			addBlockZone(bWidth, 50, classFactory(MechSelector));
			addBlockZone(200, bHeight, classFactory(ItemSelector));
			addBlockZone(bWidth, bHeight, classFactory(Ragdoll));
		}
		
		private function classFactory(cls:Class):Function {
			return function (x:int,y:int,width:int,height:int):Menu {
				return new cls(x,y,width,height);
			}
		}
	}
}