package
{
    import flash.display.Sprite;
    import screens.Screen;
    
    [SWF(width="1000", height="1000", frameRate="60", backgroundColor="0xFF00CC")]
    
    public class game_jam extends Sprite {

        protected var _currentScreen:Screen;
        
        public function game_jam() {
            initialize();
        }
        
        public function initialize():void {
            GameObjectManager.singleton.initialise();
        }
        
        public function swapScreen(screen:Screen):void {
            if (_currentScreen) {
                _currentScreen.shutdown();
            }
            _currentScreen = screen;
            _currentScreen.initialise();
        }
        
    }
}