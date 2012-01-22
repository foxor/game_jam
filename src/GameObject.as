package {
    
    import flash.display.Sprite;
    
    public class GameObject extends Sprite {
        
        public function GameObject() {
            
        }

        public function onAdd():void {
            
        }
        
        public function onRemove():void {
            
        }

        public function draw(timeDelta:int):void {
			for (var i:int = numChildren - 1; i > 0; i--) {
				if (getChildAt(i) is GameObject) {
					(getChildAt(i) as GameObject).draw(timeDelta);
				}
			}
        }
        
        public function process(timeDelta:int):void {
            for (var i:int = numChildren - 1; i > 0; i--) {
				if (getChildAt(i) is GameObject) {
					(getChildAt(i) as GameObject).process(timeDelta);
				}
			}
        }
    }
}