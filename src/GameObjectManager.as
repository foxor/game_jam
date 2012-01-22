package {
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    public class GameObjectManager extends EventDispatcher {
        
        private static var _instance:GameObjectManager;
        private var _children:Vector.<GameObject>;
        
        public function GameObjectManager() {
        }
        
        public static function get singleton():GameObjectManager {
            if (!_instance) {
                _instance = new GameObjectManager(); 
            }
            return _instance;
        }

        public function initialise():void {
            _children = new Vector.<GameObject>();
            addEventListener(Event.ENTER_FRAME, onFrameEnter);
            addEventListener(Event.EXIT_FRAME, onFrameExit);
        }
        
        public function addChild(child:GameObject):void {
            if (_children.indexOf(child) >= 0) {
                _children.push(child);    
            }
        }

        public function removeChild(child:GameObject):void {
            var index:int = _children.indexOf(child) 
            if (index >= 0) {
                _children.splice(index, 1);    
            }
        }
        
        public function onFrameEnter(event:Event):void {
            var frameDelta:int = 0;
            draw(frameDelta);
            process(frameDelta);
        }

        private function draw(frameDelta:int):void {
            for each (var child:GameObject in _children) {
                child.draw(frameDelta);
            }
        }

        private function process(frameDelta:int):void {
            for each (var child:GameObject in _children) {
                child.process(frameDelta);
            }
        }

        public function onFrameExit(event:Event):void {
            
        }
    }
}