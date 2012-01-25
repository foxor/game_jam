package gameobjects {
    
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    
    // Adds support for sorting order to Sprites
    public class GameView extends Sprite {

        protected var _sortOrder:int = int.MAX_VALUE;

        public function GameView() {
        
        }
        
        override public function addChild(child:DisplayObject):DisplayObject {
            var gObject:GameView = child as GameView;
            for (var i:int = 0; i < numChildren; i++) {
                var existingChild:GameView = getChildAt(i) as GameView;
                if (existingChild.sortOrder >= gObject.sortOrder) {
                    break;
                }
            }
            addChildAt(gObject, i);
            return child;
        }
        
        public function get sortOrder():int {
            return _sortOrder;
        }
        
        public function set sortOrder(val:int):void {
            _sortOrder = val;
        }
    }
}