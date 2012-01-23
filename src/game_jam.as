package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.utils.getTimer;

    import screens.BattleScreen;
    import screens.Mission;
    import screens.Screen;

    import gameobjects.GameObjectManager;
    import physics.PhysicsManager;
    
    [SWF(width="1000", height="1000", frameRate="60", backgroundColor="0x777777")]
    
    public class game_jam extends Sprite {

        protected var _fpsTracker:TextField;
        protected var _lastTime:int = getTimer();

        public function game_jam() {
            addEventListener(Event.ADDED_TO_STAGE, initialize, false, 0, true);
        }
        
        public function initialize(event:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, initialize);

            GameObjectManager.singleton.initialise();
            PhysicsManager.singleton.initialise();
            
			//fb_loader.load(stage);
            stage.addChild(GameObjectManager.singleton);

            setupFPS();
            
            addEventListener(Event.ENTER_FRAME, onFrameEnter);
            addEventListener(Event.EXIT_FRAME, onFrameExit);
			GameObjectManager.singleton.swapScreen(new Mission());
		}
        
        private function setupFPS():void {
            var fpsBacking:Sprite = new Sprite();
            fpsBacking.graphics.beginFill(0x000000);
            fpsBacking.graphics.drawRect(0, 0, 40, 15);
            fpsBacking.graphics.endFill();
            stage.addChild(fpsBacking);
            
            _fpsTracker = new TextField();
            _fpsTracker.textColor = 0xFFFFFF;
            _fpsTracker.width = 20
            _fpsTracker.height = 15
            stage.addChild(_fpsTracker);
        }
        
        public function onFrameEnter(event:Event):void {
            var time:int = getTimer();
            var frameDelta:int = time - _lastTime;
            var fps:Number = 1/((frameDelta)/1000.0);
            _lastTime = time;
            _fpsTracker.text = String(Math.floor(fps));
            GameObjectManager.singleton.draw(frameDelta);
            GameObjectManager.singleton.process(frameDelta);
            PhysicsManager.singleton.update(frameDelta);
        }
        
        public function onFrameExit(event:Event):void {
            
        }
        
    }
}
