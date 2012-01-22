package
{
    public class GameObjectManager
    {
        
        private var _instance:GameObjectManager;
        private var _children:Vector.<GameObject>;
        
        public function GameObjectManager()
        {
            _children = new Vector.<GameObject>();
        }
        
        public function addChild(child:GameObject):void {
            if (_children.indexOf(child) >= 0) {
                _children.push(child);    
            }
        }

        public function removeChild(child:GameObject):void {
            var index:int = _children.indexOf(child) 
            if (index >= 0) {
                _children.remove(child);    
            }
        }
    }
}