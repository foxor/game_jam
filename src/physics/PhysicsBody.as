package physics {
    import flash.geom.Vector3D;
    
    public class PhysicsBody {
        
        private var _collisionGroup:int;
        private var _position:Vector3D;
        
        public function PhysicsBody(collisionGroup:int) {
            _collisionGroup = collisionGroup;
            _position = new Vector3D();
        }
        
        public function update(dt:int):void {
            
        }

        public function collision(target:PhysicsBody):void {
            
        }
        
        public function collides(target:PhysicsBody):Boolean {
            return false;
        }
        
        public function get collisionGroup():int {
            return _collisionGroup;
        }
        
        public function set position(val:Vector3D):void {
            _position.x = val.x;
            _position.y = val.y;
            _position.z = val.z;
        }

        public function get position():Vector3D {
            return _position;
        }
    }
}