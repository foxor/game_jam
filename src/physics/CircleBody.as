package physics {

    public class CircleBody extends PhysicsBody {
        
        private var _radius:int;
        
        public function CircleBody(radius:int) {
            super();
        }
        
        public function collision(target:PhysicsBody):void {
            //if (position.length + target.position.length <  
        }

        public function get radius():int {
            return _radius;
        }
    }
}