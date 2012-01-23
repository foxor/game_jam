package screens
{
	public class ItemSelector extends LayoutMenu
	{
		public function ItemSelector(x:int=0, y:int=0, width:int=1000, height:int=1000)
		{
			super(x, y, width, height);
			addBlockZone(width, height/5, itemFactory("Sniper Rifle"));
			addBlockZone(width, height/5, itemFactory("Rocket Launcher"));
			addBlockZone(width, height/5, itemFactory("Machine Gun"));
			addBlockZone(width, height/5, itemFactory("Flame Thrower"));
			addBlockZone(width, height/5, itemFactory("Plasme Torch"));
		}
		
		private function itemFactory(text:String):Function {
			return function(x:int, y:int, width:int, height:int):Menu {
				return new ItemSingle(text, x, y, width, height);
			}
		}
	}
}