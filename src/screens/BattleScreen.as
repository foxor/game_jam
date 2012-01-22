package screens {

    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    
    import gameobjects.GameObject;
    import gameobjects.GameObjectManager;
    
    import battle.Mech;
    
    public class BattleScreen extends Screen {
        
        public static const MAX_WIDTH:int = 1000;
        public static const MAX_HEIGHT:int = 1000;

        private var _activeMech:Mech;
        private var _mechs:Array;
        private var _background:GameObject;
        
        public function BattleScreen() {
            _mechs = new Array();
        }
        
        override public function initialize():void {
            _background = new GameObject();
            _background.sortOrder = 10;
            _background.graphics.beginFill(0xCD853F);
            _background.graphics.drawRect(0, 0, 1000, 1000);
            _background.graphics.endFill();
            GameObjectManager.singleton.addChild(_background);
            
            for (var i:int = 0; i < 10; i++) {
                var mech:Mech = new Mech(this);
                GameObjectManager.singleton.addChild(mech);
                mech.x += Math.random() * MAX_WIDTH;
                mech.y += Math.random() * MAX_HEIGHT;
                _mechs.push(mech);
            }
            
            GameObjectManager.singleton.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
            GameObjectManager.singleton.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
        }
        
        override public function shutDown():void {
            GameObjectManager.singleton.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            GameObjectManager.singleton.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
        
            for each (var mech:Mech in _mechs) {
                GameObjectManager.singleton.removeChild(mech);
            }
            GameObjectManager.singleton.removeChild(_background);
        }
        
        public function mouseDownHandler(evt:MouseEvent):void {
            trace("mouseDown", evt.stageX, evt.stageY, evt.localX, evt.localY);
            if (_activeMech) {
                _activeMech.target = new Point(evt.localX, evt.localY);
            }
        }
        
        public function mouseUpHandler(evt:MouseEvent):void {
            trace("mouseUp", evt.stageX, evt.stageY, evt.localX, evt.localY);
        }
        
        public function set activeMech(val:Mech):void {
            if (_activeMech) {
                _activeMech.removeSelectionHighlight();
            }
            _activeMech = val;
            _activeMech.addSelectionHighlight();
        }

        public function get activeMech():Mech {
            return _activeMech;
        }
    }
}