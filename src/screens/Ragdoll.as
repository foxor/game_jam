package screens
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import game.Game;
	
	import gameobjects.GameView;

	public class Ragdoll extends Menu
	{
		public function Ragdoll(x:int=0, y:int=0, width:int=1000, height:int=1000)
		{
			super(x, y, width, height);
			var ragdoll:Sprite = new Sprite();
			fb_loader.load(ragdoll);
			ragdoll.x = bWidth / 2;
			ragdoll.y = bHeight / 2;
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill(0xA03010);
			bg.graphics.drawRect(5, 5, width - 10, height - 10);
			bg.graphics.endFill();
			var button:Sprite = new Sprite();
			button.graphics.beginFill(0x00FF00);
			button.graphics.drawRect(width - 80, height - 40, 70, 30);
			button.graphics.endFill();
			ExternalInterface.addCallback("authAs3", function ():void {
				Game.singleton.swapScreen(new Mission());
			});
			button.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				if (ExternalInterface.call("authJs") == null) {
					Game.singleton.swapScreen(new Mission());
				}
			});
			var container:GameView = new GameView();
			container.x = left;
			container.y = top;
			container.addChild(bg);
			container.addChild(ragdoll);
			container.addChild(button);
			this.responsibilities.push(container);
		}
	}
}
