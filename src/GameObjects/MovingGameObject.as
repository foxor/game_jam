package gameobjects {
    
    import flash.geom.Vector3D;

    import game.Game;
    import physics.MovingBody;
    
    public class MovingGameObject extends GameObject {
        
        private var _body:MovingBody;

        public function MovingGameObject() {
            _body = new MovingBody(Game.COLLISION_MECHS);
        }
        
        override public function process(timeDelta:int):void {
            x = _body.position.x; 
            y = _body.position.y; 
        }

        public function moveTo(x:int ,y:int , z:int = 0):void {
            _body.target = new Vector3D(x, y, z);
        }
        
        public function setPosition(x:int ,y:int , z:int = 0):void {
            _body.position = new Vector3D(x, y, z);
        }
    }
}