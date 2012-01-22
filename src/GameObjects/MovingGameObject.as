package GameObjects {
    
    import flash.geom.Point;
    import flash.geom.Vector3D;
    
    public class MovingGameObject extends GameObject {
        
        public var velocity:Vector3D;
        public var speed:int = 5;
        
        private var _target:Point;
        
        public function MovingGameObject() {
            
        }
        
        override public function process(timeDelta:int):void {
            if (_target) {
                var deltaX:int = _target.x - x;
                var deltaY:int = _target.y - y;
                if ((deltaX < speed && deltaX > -speed) && (deltaY < speed && deltaY > -speed)) {
                    x = _target.x;
                    y = _target.y;
                    _target = null;
                } else {
                    x += velocity.x;
                    y += velocity.y;
                }
            }            
            super.process(timeDelta);
        }
        
        public function set target(val:Point):void {
            _target = val;
            velocity = new Vector3D((val.x - x), (val.y - y), 0);
            velocity.normalize();
            velocity.x *= speed;
            velocity.y *= speed;
        }
        
        public function get target():Point {
            return _target;
        }
    }
}