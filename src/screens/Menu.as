package screens
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	public class Menu extends Screen
	{
		private var responsibilities:Vector.<GameObject> = new Vector.<GameObject>();
		
		protected var boundingBox:Rectangle;
		
		public function Menu(title:String, x:int=0, y:int=0, width:int=1000, height:int=1000)
		{
			boundingBox = new Rectangle(x, y, width, height);
			var background:GameObject = new GameObject();
			background.sortOrder = 10;
			background.graphics.beginFill(0xCD853F);
			background.graphics.drawRect(0, 0, 1000, 1000);
			background.graphics.endFill();
			GameObjectManager.singleton.addChild(background);
			
			buildTitle(title);
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
			title.sortOrder = 100;
			GameObjectManager.singleton.addChild(title);
			responsibilities.push(title);
			top = 60;
		}
		
		protected function addOption(color:Number, text:String):void {
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill(0xA03010);
			bg.graphics.drawRect(0, 0, 1000, 50);
			bg.graphics.endFill();
			var textField:TextField = new TextField();
			textField.text = text;
			textField.x = 60 + (940 - textField.width) / 2;
			textField.y = 20;
			var difficulty:Sprite = new Sprite();
			difficulty.graphics.beginFill(color);
			difficulty.graphics.drawCircle(25, 25, 5);
			difficulty.graphics.endFill();
			var option:GameObject = new GameObject();
			option.addChild(bg);
			option.addChild(textField);
			option.addChild(difficulty);
			option.sortOrder = 100;
			option.y = top;
			GameObjectManager.singleton.addChild(option);
			responsibilities.push(option);
			top += 60;
			option.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				onClick(text);
			});
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
