package
{
    import flash.display.Sprite;
    
    [SWF(width="1000", height="1000", frameRate="60", backgroundColor="0xFF00CC")]
    
    public class game_jam extends Sprite
    {

        public function game_jam() {
            initialize();
        }
        
        public function initialize():void {
            GameObjectManager.singleton.initialise();
        }
    }
}