package screens
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import gameobjects.GameObject;
	import gameobjects.GameObjectManager;

	public class ItemSingle extends Menu
	{
		public function ItemSingle(text:String, x:int=0, y:int=0, width:int=1000, height:int=1000)
		{
			super(x, y, width, height);
			
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill(0xA03010);
			bg.graphics.drawRect(5, 5, width - 10, height - 10);
			bg.graphics.endFill();
			var textField:TextField = new TextField();
			textField.text = text;
			textField.x = (width - textField.width) / 2;
			textField.y = 20;
			var item:GameObject = new GameObject();
			item.sortOrder = 100;
			item.addChild(bg);
			item.addChild(textField);
			item.x = left;
			item.y = top;
			GameObjectManager.singleton.addChild(item);
			this.responsibilities.push(item);
		}
	}
}