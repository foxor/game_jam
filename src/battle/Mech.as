package battle {

    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Vector3D;
    
    import game.Game;
    
    import gameobjects.GameObjectManager;
    import gameobjects.MovingGameObject;
    
    import particle.Circle;
    import particle.Explosion;
    
    import physics.MovingBody;
    import physics.PhysicsBody;
    import physics.PhysicsManager;
    
    import screens.BattleScreen;
    
    public class Mech extends MovingGameObject {
        
        public static var MECH_COLOUR:int = 0x888888
        public static var MECH_SIZE:int = 30;
        
        private var _teamId:String;
        private var _owner:BattleScreen;
        private var _selectionHighlight:Sprite;
		private var _range:MechRange;
        
        public function Mech(owner:BattleScreen) {
            super();
            _owner = owner;
            _sortOrder = 100;
            addChild(new Circle(MECH_COLOUR, MECH_SIZE));

            var arm:Sprite = new Sprite();
            arm.graphics.beginFill(0x000000);
            arm.graphics.drawRect(0, 0, 80, 10);
            arm.graphics.endFill();
                        
            addChild(arm);
            
			fb_loader.load(this);
			PhysicsManager.singleton.addBody(_range = new MechRange(this));
        }

        override public function onAdd():void {

        }
        
        override public function onRemove():void {

        }
		
		public function fireAt(opponent:Mech):void {
			opponent.addChild(new Explosion());
		}
        
        public function insideBounds(targetX:int, targetY:int):Boolean {
            return ((targetX > x && targetX < x + width) && (targetY > y && targetX < y + height)); 
        }
        
        public function addSelectionHighlight():void {
            _selectionHighlight = new Circle(0xFF00FF, 32);
            addChildAt(_selectionHighlight, 0);
        }

        public function removeSelectionHighlight():void {
            removeChild(_selectionHighlight);
        }
        
        public function set teamId(val:String):void {
            _teamId = val;
        }

        public function get teamId():String {
            return _teamId;
        }
		
		override public function notifyMove(val:Vector3D):void {
			_range.position = val;
		}
    }
}