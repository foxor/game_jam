package physics {
    
    public class PhysicsBody {
        
        private var _collisionGroup:int;
        
        public function PhysicsBody(collisionGroup:int) {
            _collisionGroup = collisionGroup;
        }
        
        public function update(dt:int):void {
            
        }

        public function collision(target:PhysicsBody):void {
            
        }
        
        public function get collisionGroup():int {
            return _collisionGroup;
        }
    }
}