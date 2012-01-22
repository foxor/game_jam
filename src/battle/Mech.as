package battle {

    import flash.display.Sprite;
    import flash.events.MouseEvent;
	
	import particle.Circle;
	import particle.Emitter;
    
    public class Mech extends GameObject {
        
        public function Mech() {
            addChild(new Circle());
			addChild(new Emitter(Circle));
        }

        override public function onAdd():void {
            GameObjectManager.singleton.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
            GameObjectManager.singleton.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
        }
        
        override public function onRemove():void {
            GameObjectManager.singleton.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            GameObjectManager.singleton.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
        }
        
        public function mouseDownHandler(evt:MouseEvent):void {
            trace("mouseDown");
        }
        
        public function mouseUpHandler(evt:MouseEvent):void {
            trace("mouseUp");
        }
    }
}