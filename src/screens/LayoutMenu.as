package screens
{
	import battle.Mech;
	
	import flash.display.Sprite;

	public class LayoutMenu extends Menu
	{
		private var layerTop:int = 0;
		private var layerLeft:int = 0;
		
		public function LayoutMenu(x:int=0, y:int=0, width:int=1000, height:int=1000)
		{
			super(x, y, width, height);
		}
		
		protected function addBlockZone(width:int, height:int, factory:Function):void {
			var child:Menu = factory(layerLeft, top, width, height);
			this.responsibilities.push(child);
			layerTop = Math.max(layerTop, top, top + height);
			layerLeft = Math.max(layerLeft, left, left + width);
			if (width == this.width) {
				top = layerTop;
			}
			if (height == this.height) {
				left = layerLeft;
			}
		}
		
		override public function shutDown():void {
			for (var i:int = 0; i < this.responsibilities.length; i++) {
				if (this.responsibilities[i] is Screen) {
					(this.responsibilities[i] as Screen).shutDown();
				} else {
					GameObjectManager.singleton.removeChild(this.responsibilities[i]);
				}
			}
		}
	}
}