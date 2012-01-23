package physics {
    
    public class PhysicsManager {
        
        private static var _instance:PhysicsManager;

        private var _collisionGroups:Object;

        private var _bodyGroups:Object;
        private var _bodiesToAdd:Array;
        private var _bodiesToRemove:Array;
        
        public function PhysicsManager() {
        }
        
        public static function get singleton():PhysicsManager {
            if (!_instance) {
                _instance = new PhysicsManager();
            }
            return _instance;
        }
        
        public function initialise():void {
            _collisionGroups = new Object();
            _bodyGroups = new Object();
            _bodiesToAdd = new Array();
            _bodiesToRemove = new Array();
        }
        
        public function shutdown():void {
            _collisionGroups = null;
            _bodyGroups = null;
            _bodiesToAdd = null;
            _bodiesToRemove = null;
        }
        
        public function update(dt:int):void {
            // Actually push any new bodies
            for each (body in _bodiesToAdd) {
                pushBody(body);
            }
            _bodiesToAdd.length = 0;
            // Actually pop any removed bodies
            for each (body in _bodiesToRemove) {
                popBody(body);
            }
            _bodiesToRemove.length = 0;

            // Update each bodies position
            for (var group:String in _bodyGroups) {
                for each (var body:PhysicsBody in _bodyGroups[group]) {
                    body.update(dt);
                }
            }

            // check any bodies are colliding
            for (group in _bodyGroups) {
                for each (body in _bodyGroups[group]) {
                    checkCollisions(body);
                }
            }
        }
        
        public function checkCollisions(source:PhysicsBody):void {
            for each (var collisionGroup:String in _collisionGroups[source.collisionGroup]) {
                for each (var potentialCollider:PhysicsBody in _bodyGroups[collisionGroup]) {
                    if (source != potentialCollider) {
                        if (collides(source, potentialCollider)) {
                            source.collision(potentialCollider);
                        }
                    }
                }
            }
        }
        
        public function collides(bodyA:PhysicsBody, bodyB:PhysicsBody):Boolean {
            return false;
        }

        public function addBody(body:PhysicsBody):void {
            // prep the body for adding (done post update)
            _bodiesToAdd.push(body);
        }
                
        public function removeBody(body:PhysicsBody):void {
            // prep the body for removal (done post update)
            _bodiesToRemove.push(body);
        }
        
        private function pushBody(body:PhysicsBody):void {
            // actually add the body to evaluated list
            if (!_bodyGroups[body.collisionGroup]) {
                _bodyGroups[body.collisionGroup] = new Array();
            }
            _bodyGroups[body.collisionGroup].push(body);
        }

        private function popBody(body:PhysicsBody):void {
            // actually remove the body from the list
            if (!_bodyGroups[body.collisionGroup]) {
                throw new Error("PopBody failed, no group for body!");
            }
            var index:int = _bodyGroups[body.collisionGroup].indexOf(body);
            if (index > 0) {
                _bodyGroups[body.collisionGroup].slice(index, 1);
            }
        }

        public function addCollisionGroup(groupA:int, groupB:int):void {
            if (!_collisionGroups[groupA]) {
                _collisionGroups[groupA] = new Array();
            }
            _collisionGroups[groupA].push(groupB);

            if (!_collisionGroups[groupB]) {
                _collisionGroups[groupB] = new Array();
            }
            _collisionGroups[groupB].push(groupA);
        }
    }
}