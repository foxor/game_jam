package physics {
    
    public class PhysicsManager {
        
        private static var _instance:PhysicsManager;

        private var _collisionPairs:Array;

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
            _collisionPairs = new Array();
            _bodyGroups = new Object();
            _bodiesToAdd = new Array();
            _bodiesToRemove = new Array();
        }
        
        public function shutdown():void {
            _collisionPairs = null;
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
            var bodyA:PhysicsBody;
            var bodyB:PhysicsBody;
            for each (var pair:Array in _collisionPairs) {
                var groupA:int = pair[0]; 
                var groupB:int = pair[1]; 
                if (groupA == groupB) {
                    // prevent double checking bodies from the same group
                    var numBodies:int = _bodyGroups[groupA].length;
                    if (numBodies > 1) {
                        for (var i:int = 0; i < numBodies - 1; i++) {
                            bodyA = _bodyGroups[groupA][i];
                            for (var j:int = i + 1; i < numBodies; j++) {
                                bodyB = _bodyGroups[groupB][j]
                                if (bodyA.collides(bodyB)) {
                                    bodyA.collision(bodyB);
                                    bodyB.collision(bodyA);
                                }
                            }
                        }
                    }
                } else {
                    for each (bodyA in _bodyGroups[groupA]) {
                        for each (bodyB in _bodyGroups[groupB]) {
                            if (bodyA.collides(bodyB)) {
                                bodyA.collision(bodyB);
                                bodyB.collision(bodyA);
                            }
                        }
                    }
                }
            }
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

        public function addCollisionPair(groupA:int, groupB:int):void {
            for each (var pair:Array in _collisionPairs) {
                if ((pair[0] == groupA && pair[1] == groupB) || (pair[0] == groupB && pair[1] == groupA)) {
                    trace("[PhysicsManager] Warning, ignoring attempt to add duplicate pair", groupA, groupB);
                    return;
                }
            }
            _collisionPairs.push([groupA, groupB]);
        }
    }
}