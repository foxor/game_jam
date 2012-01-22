package screens
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	public class Menu extends Screen
	{
		protected var responsibilities:Vector.<Sprite> = new Vector.<Sprite>();
		
		protected var boundingBox:Rectangle;
		
		public function Menu(x:int=0, y:int=0, width:int=1000, height:int=1000)
		{
			boundingBox = new Rectangle(x, y, width, height);
			var background:GameObject = new GameObject();
			background.sortOrder = 10;
			background.graphics.beginFill(0xCD853F);
			background.graphics.drawRect(0, 0, 1000, 1000);
			background.graphics.endFill();
			GameObjectManager.singleton.addChild(background);
		}
		
		protected function set top (val:int):void {
			var change:int = top - val;
			boundingBox.top = val;
			boundingBox.height += change;
		}
		
		protected function get top():int {
			return boundingBox.top;
		}
		
		protected function set left (val:int):void {
			var change:int = left - val;
			boundingBox.left = val;
			boundingBox.width += change;
		}
		
		protected function get left():int {
			return boundingBox.left;
		}
		
		protected function get bWidth():int {
			return boundingBox.width;
		}
		
		protected function get bHeight():int {
			return boundingBox.height;
		}
		
		protected function buildTitle(text:String):void {
			var textField:TextField = new TextField();
			textField.text = text;
			textField.x = (1000 - textField.width) / 2;
			textField.y = 20;
			var hBar:Sprite = new Sprite();
			hBar.graphics.beginFill(0x000000);
			hBar.graphics.drawRect(0, 50, 1000, 10);
			hBar.graphics.endFill();
			var title:GameObject = new GameObject();
			title.addChild(hBar);
			title.addChild(textField);
			title.x = left;
			title.y = top;
			title.sortOrder = 100;
			GameObjectManager.singleton.addChild(title);
			responsibilities.push(title);
			top += 60;
		}
		
		protected function onClick(btnName:String):void {
			GameObjectManager.singleton.swapScreen(new BattleScreen());
		}
		
		override public function shutDown():void {
			for (var i:int = 0; i < responsibilities.length; i++) {
				GameObjectManager.singleton.removeChild(responsibilities[i]);
			}
			parent.removeChild(this);
		}
	}
}
