package gameobjects {
    
    import flash.geom.Vector3D;

    import game.Game;
    import physics.MovingBody;
    import physics.PhysicsManager;
    
    public class MovingGameObject extends GameObject {
        
        private var _body:MovingBody;

        public function MovingGameObject() {
            _body = new MovingBody(Game.COLLISION_MECHS, this);
            PhysicsManager.singleton.addBody(_body);
        }
        
        override public function process(timeDelta:int):void {
            x = _body.position.x; 
            y = _body.position.y; 
			super.process(timeDelta);
        }

        public function moveTo(x:int ,y:int , z:int = 0):void {
            _body.target = new Vector3D(x, y, z);
        }
        
        public function setPosition(x:int ,y:int , z:int = 0):void {
            _body.position = new Vector3D(x, y, z);
        }
    }
}