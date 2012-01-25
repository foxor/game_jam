package screens
{
	import battle.Mech;
	
	import flash.display.Sprite;
	
	import gameobjects.GameObject;
	import gameobjects.GameObjectManager;

	public class LayoutMenu extends Menu
	{
		private var layerTop:int;
		private var layerLeft:int;
		
		public function LayoutMenu(x:int=0, y:int=0, width:int=1000, height:int=1000)
		{
			super(x, y, width, height);
			layerTop = top;
			layerLeft = left;
		}
		
		protected function addBlockZone(width:int, height:int, factory:Function):void {
			var child:Menu = factory(layerLeft, top, width, height);
			this.responsibilities.push(child);
			layerTop = Math.max(layerTop, top, top + height);
			layerLeft = Math.max(layerLeft, left, left + width);
			if (bWidth == layerLeft) {
				top = layerTop;
				layerLeft = 0;
			}
		}
		
		override public function shutDown():void {
			for (var i:int = 0; i < this.responsibilities.length; i++) {
				if (this.responsibilities[i] is Screen) {
					(this.responsibilities[i] as Screen).shutDown();
				} else if (this.responsibilities[i] is GameObject) {
					GameObjectManager.singleton.removeGameObject(this.responsibilities[i] as GameObject);
				} else {
                    removeChild(this.responsibilities[i]);
                }
			}
		}
	}
}