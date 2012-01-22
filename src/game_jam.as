package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.utils.getTimer;

    import screens.Screen;
    
    [SWF(width="1000", height="1000", frameRate="60", backgroundColor="0x777777")]
    
    public class game_jam extends Sprite {

        protected var _currentScreen:Screen;
        protected var _fpsTracker:TextField;
        protected var _lastTime:int = getTimer();

        public function game_jam() {
            addEventListener(Event.ADDED_TO_STAGE, initialize, false, 0, true);
        }
        
        public function initialize(event:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, initialize);

            GameObjectManager.singleton.initialise();
			//fb_loader.load(stage);
            stage.addChild(GameObjectManager.singleton);

            _fpsTracker = new TextField();
            _fpsTracker.textColor = 0xFFFFFF;
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
