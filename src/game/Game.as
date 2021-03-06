package game {
    
    import flash.display.Sprite;

    import gameobjects.GameObjectManager;
    import physics.PhysicsManager;
    import screens.Screen;
    
    public class Game extends Sprite {
        
        public static const COLLISION_MECHS:int = 1;
        public static const COLLISION_WEAPONS:int = 2;
		public static const COLLISION_MECH_RANGE:int = 3;

        protected var _currentScreen:Screen;
        
        private static var _instance:Game;

        public function Game() {
                            
        }
        
        public static function get singleton():Game {
            if (!_instance) {
                _instance = new Game();
            }            
            return _instance;
        }
        
        public function initialise():void {
            PhysicsManager.singleton.addCollisionPair(COLLISION_MECHS, COLLISION_MECHS);
			PhysicsManager.singleton.addCollisionPair(COLLISION_MECHS, COLLISION_WEAPONS);
			PhysicsManager.singleton.addCollisionPair(COLLISION_MECHS, COLLISION_MECH_RANGE);
        }
        
        public function swapScreen(screen:Screen):void {
            if (_currentScreen) {
                _currentScreen.shutDown();
                stage.removeChild(_currentScreen);
            }
            _currentScreen = screen;
            stage.addChild(_currentScreen);
            _currentScreen.initialize();
        }
    }
}