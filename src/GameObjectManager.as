package {
    
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.EventDispatcher;
    
    public class GameObjectManager extends Sprite {
        
        private static var _instance:GameObjectManager;
        
        public function GameObjectManager() {
        }
        
        public static function get singleton():GameObjectManager {
            if (!_instance) {
                _instance = new GameObjectManager(); 
            }
            return _instance;
        }

        public function initialise():void {
        }
        
        override public function addChild(child:DisplayObject):DisplayObject {
            super.addChild(child);
            (child as GameObject).onAdd();
            return child;
        }
        
        override public function removeChild(child:DisplayObject):DisplayObject {
            super.removeChild(child);
            (child as GameObject).onRemove();
            return child;
        }
        
        public function draw(frameDelta:int):void {
            for (var i:int; i < numChildren; i++) {
                var child:GameObject = getChildAt(i) as GameObject;
                child.draw(frameDelta);
            }
        }

        public function process(frameDelta:int):void {
            for (var i:int; i < numChildren; i++) {
                var child:GameObject = getChildAt(i) as GameObject;
                child.process(frameDelta);
            }
        }

    }
}