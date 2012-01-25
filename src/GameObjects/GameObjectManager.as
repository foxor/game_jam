package gameobjects {
    
    import flash.events.EventDispatcher;
    
    public class GameObjectManager {
        
        private static var _instance:GameObjectManager;
        private var _guid:int;
        private var _gameObjects:Vector.<GameObject>;
        
        public function GameObjectManager() {
            _guid = 0;
            _gameObjects = new Vector.<GameObject>();
        }
        
        public static function get singleton():GameObjectManager {
            if (!_instance) {
                _instance = new GameObjectManager(); 
            }
            return _instance;
        }

        public function initialise():void {
        }
        
        public function addGameObject(child:GameObject):GameObject {
            _gameObjects.push(child);
            child.onAdd();
            return child;
        }
        
        public function removeGameObject(child:GameObject):GameObject {
            var index:int = _gameObjects.indexOf(child);
            if (index > 0) {
                _gameObjects.splice(index,1);
            }
            child.onRemove();
            return child;
        }
        
        public function draw(frameDelta:int):void {
            for each (var child:GameObject in _gameObjects) {
                child.draw(frameDelta);
            }
        }

        public function process(frameDelta:int):void {
            for each (var child:GameObject in _gameObjects) {
                child.process(frameDelta);
            }
        }

        public function get guid():int {
            return _guid++;
        }
    }
}