package screens {

    import battle.Mech;
    
    public class BattleScreen extends Screen {
        
        private var _mechs:Array;
        
        public function BattleScreen() {
            _mechs = new Array();
        }
        
        override public function initialize():void {
            for (var i:int = 0; i < 1; i++) {
                var mech:Mech = new Mech();
                GameObjectManager.singleton.addChild(mech);
            }
        }
    }
}