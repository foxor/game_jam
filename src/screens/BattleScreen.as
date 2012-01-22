package screens {

    import flash.events.MouseEvent;
    import flash.display.Sprite;
    import battle.Mech;
    
    public class BattleScreen extends Screen {
        
        private var _mechs:Array;
        
        public function BattleScreen() {
            _mechs = new Array();
        }
        
        override public function initialize():void {
            var background:GameObject = new GameObject();
            background.sortOrder = 10;
            background.graphics.beginFill(0xCD853F);
            background.graphics.drawRect(0, 0, 1000, 1000);
            background.graphics.endFill();
            GameObjectManager.singleton.addChild(background);
            
            for (var i:int = 0; i < 1; i++) {
                var mech:Mech = new Mech();
                GameObjectManager.singleton.addChild(mech);
            }
            
            GameObjectManager.singleton.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
            GameObjectManager.singleton.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
        }
        
        override public function shutDown():void {
            GameObjectManager.singleton.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            GameObjectManager.singleton.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
        }
        
        public function mouseDownHandler(evt:MouseEvent):void {
            trace("mouseDown", evt.stageX, evt.stageY, evt.localX, evt.localY);
        }
        
        public function mouseUpHandler(evt:MouseEvent):void {
            trace("mouseUp", evt.stageX, evt.stageY, evt.localX, evt.localY);
        }
    }
}