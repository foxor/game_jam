package {
    
    import flash.display.Sprite;
    
    public class GameObject extends Sprite {
        
        protected var _sortOrder:int = int.MAX_VALUE;
        
        public function GameObject() {
            
        }

        public function onAdd():void {
            
        }
        
        public function onRemove():void {
            
        }

        public function draw(timeDelta:int):void {
            
        }
        
        public function process(timeDelta:int):void {
            
        }
        
        public function get sortOrder():int {
            return _sortOrder;
        }

        public function set sortOrder(val:int):void {
            _sortOrder = val;
        }
    }
}