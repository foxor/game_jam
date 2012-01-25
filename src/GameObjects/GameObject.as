package gameobjects {
    
    import flash.display.Sprite;
    import flash.geom.Vector3D;
    
    public class GameObject extends GameView {
        
        private var _guid:int;
        
        public function GameObject() {
            _guid = GameObjectManager.singleton.guid;
        }

        public function onAdd():void {
            
        }
        
        public function onRemove():void {
            
        }
		
		public function get totalX():int {
			if (parent && parent is GameObject) {
				return x + (parent as GameObject).totalX;
			}
			return x;
		}
		
		public function get totalY():int {
			if (parent && parent is GameObject) {
				return y + (parent as GameObject).totalY;
			}
			return y;
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
        
        public function get guid():int {
            return _guid;
        }
		
		public function notifyMove(val:Vector3D):void {
		}
    }
}