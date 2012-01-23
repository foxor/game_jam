package physics {
    
    import flash.geom.Point;
    import flash.geom.Vector3D;
    
    public class MovingBody extends PhysicsBody {
        
        public var velocity:Vector3D;
        public var speed:int = 5;
        
        private var _target:Vector3D;
        
        public function MovingBody(collisionGroup:int) {
            super(collisionGroup);
        }
        
        override public function update(dt:int):void {
            if (_target) {
                var deltaX:int = _target.x - _position.x;
                var deltaY:int = _target.y - _position.y;
                if ((deltaX < speed && deltaX > -speed) && (deltaY < speed && deltaY > -speed)) {
                    _position.x = _target.x;
                    _position.y = _target.y;
                    _target = null;
                } else {
                    _position.x += velocity.x;
                    _position.y += velocity.y;
                }
            }            
            super.update(dt);
        }
        
        public function set target(val:Vector3D):void {
            _target = val;
            velocity = new Vector3D((val.x - _position.x), (val.y - _position.y), 0);
            velocity.normalize();
            velocity.x *= speed;
            velocity.y *= speed;
        }
        
        public function get target():Vector3D {
            return _target;
        }
    }
}