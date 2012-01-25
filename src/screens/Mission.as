package screens
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import gameobjects.GameView;

    public class Mission extends Menu
    {
        public function Mission(title:String="Mision Menu")
        {
            super();
			
			buildTitle(title);
			
			addOption(0x00FF00, "Easy");
			addOption(0xFFFF00, "Medium");
			addOption(0xFF0000, "Hard");
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
			var option:GameView = new GameView();
			option.addChild(bg);
			option.addChild(textField);
			option.addChild(difficulty);
			option.sortOrder = 100;
			option.y = top;
			responsibilities.push(option);
			top += 60;
			option.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				onClick(text);
			});
		}
    }
}
