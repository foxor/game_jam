package
{
    public class Renderer
    {
        private static _instance:Renderer;
        
        public function Renderer()
        {
            
        }
        
        public function singleton():Renderer {
            if (!_instance) {
                _instance = new Renderer();
            }
            
            return _instance;
        }
        
        public function onFrame():void {
            
        }
    }
}