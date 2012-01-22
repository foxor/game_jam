package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.utils.getTimer;

    import screens.Screen;
    
    [SWF(width="1000", height="1000", frameRate="60", backgroundColor="0xFF00CC")]
    
    public class game_jam extends Sprite {

        protected var _currentScreen:Screen;
        protected var _fpsTracker:TextField;
        protected var _lastTime:int = getTimer();

        public function game_jam() {
            initialize();
        }
        
        public function initialize():void {
            GameObjectManager.singleton.initialise();
			fb_loader.load(GameObjectManager.singleton);
            stage.addChild(GameObjectManager.singleton);

            _fpsTracker = new TextField();
            _fpsTracker.textColor = 0xFFFF0000;
            stage.addChild(_fpsTracker);
            
            addEventListener(Event.ENTER_FRAME, onFrameEnter);
            addEventListener(Event.EXIT_FRAME, onFrameExit);
        }
        
        public function onFrameEnter(event:Event):void {
            var time:int = getTimer();
            var frameDelta:int = time - _lastTime;
            var fps:Number = 1/((frameDelta)/1000.0);
            _lastTime = time;
            _fpsTracker.text = String(Math.floor(fps));
            GameObjectManager.singleton.draw(frameDelta);
            GameObjectManager.singleton.process(frameDelta);
        }
        
        public function onFrameExit(event:Event):void {
            
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
