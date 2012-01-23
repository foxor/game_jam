package battle {

    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    
    import gameobjects.GameObjectManager;
    import gameobjects.MovingGameObject;
    
    import particle.Circle;
    import particle.Explosion;
    
    import physics.PhysicsBody;
    
    import screens.BattleScreen;
    
    public class Mech extends MovingGameObject {
        
        private var _teamId:String;
        private var _owner:BattleScreen;
        private var _selectionHighlight:Sprite;
        private var _body:PhysicsBody;
        
        public function Mech(owner:BattleScreen) {
            _owner = owner;
            _sortOrder = 100;
            addChild(new Circle());
			fb_loader.load(this);
        }

        override public function onAdd():void {

        }
        
        override public function onRemove():void {

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
            _teamId = teamId;
        }

        public function get teamId():String {
            return _teamId;
        }
    }
}