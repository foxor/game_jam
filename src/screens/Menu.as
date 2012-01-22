package screens
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class Menu extends Screen
	{
		private var responsibilities:Vector.<GameObject> = new Vector.<GameObject>();
		protected var bottom:int = 0;
		
		public function Menu(title:String)
		{
			var background:GameObject = new GameObject();
			background.sortOrder = 10;
			background.graphics.beginFill(0xCD853F);
			background.graphics.drawRect(0, 0, 1000, 1000);
			background.graphics.endFill();
			GameObjectManager.singleton.addChild(background);
			
			buildTitle(title);
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
			bottom = 60;
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
			option.y = bottom;
			GameObjectManager.singleton.addChild(option);
			responsibilities.push(option);
			bottom += 60;
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
