package physics {
    import flash.geom.Point;
    import flash.geom.Vector3D;
    
    import gameobjects.GameObject;
    
    public class PhysicsBody {
        
        protected var _collisionGroup:int;
        protected var _position:Vector3D;
        protected var _width:int;
        protected var _height:int;
		
		public var gameObject:GameObject;
        
        public function PhysicsBody(collisionGroup:int, gameObject:GameObject=null) {
            _collisionGroup = collisionGroup;
            _position = new Vector3D();
			this.gameObject = gameObject;
        }
        
        public function update(dt:int):void {
            
        }

        public function collision(target:PhysicsBody):void {
        }
                
        public function get width():int {
            return _width;
        }
        
        public function set width(val:int):void {
            _width = val;
        }
        
        public function get height():int {
            return _height;
        }
        
        public function set height(val:int):void {
            _height = val;
        }
        
        public function collides(target:PhysicsBody):Boolean {
            return ((position.x + width > target.position.x) && (position.x < target.position.x + target.width)) && ((position.y + height > target.position.y) && (position.y < target.position.y + target.height));
        }
        
        public function get collisionGroup():int {
            return _collisionGroup;
        }
        
        public function set position(val:Vector3D):void {
            _position.x = val.x;
            _position.y = val.y;
            _position.z = val.z;
			if (gameObject) {
				gameObject.notifyMove(val);
			}
        }
		
		public function copyPoint(x:int, y:int, z:int=0):void {
			_position.x = x;
			_position.y = y;
			_position.z = 0;
		}

        public function get position():Vector3D {
            return _position;
        }
    }
}