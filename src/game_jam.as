package
{
    import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.display.LoaderInfo;
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.MouseEvent;
    import flash.external.ExternalInterface;
    import flash.system.Security;
    import flash.utils.getDefinitionByName;
    import flash.utils.getTimer;
    
    
    [SWF(width="1000", height="1000", frameRate="60", backgroundColor="0xFF00CC")]
    
    public class game_jam extends Sprite
    {
        private static const WIDTH:uint = 1000;
        private static const HEIGHT:uint = 1000;
        private static const GRID_COUNT:uint = 200;
        private static const GRID_WIDTH:uint = WIDTH / GRID_COUNT;
        private static const GRID_HEIGHT:uint = HEIGHT / GRID_COUNT;
        private static const GRID_WIDTH_MUL:Number = 1 / GRID_WIDTH;
        private static const GRID_HEIGHT_MUL:Number = 1 / GRID_HEIGHT;
        
        private var _bitmap:Bitmap;
        private var _bitmapData:BitmapData;
        private var _cells:Array;
        private var _pending:Array;
        private var _alive:Array;
        private var _fps:TextField;
        private var _dirty:Array;
        
        private var _total:int = 0;
        private var _startTime:Date;

        public function game_jam()
        {
            initialize();
            addEventListener(Event.ENTER_FRAME, update);
        }
        
        public function initialize():void {
            _bitmapData = new BitmapData(WIDTH, HEIGHT, false, 0);
            _bitmap = new Bitmap(_bitmapData);
            addChild(_bitmap);
            _cells = new Array(WIDTH+1);
            _pending = new Array(WIDTH+1);
            _alive = new Array(WIDTH+1);
            for (var i:uint = 0; i < WIDTH; i++) {
                _pending[i] = new Array(HEIGHT+1);
                _cells[i] = new Array(HEIGHT+1);
                _alive[i] = new Array(HEIGHT+1);
                for (var j:uint = 0; j < HEIGHT; j++) {
                    _cells[i][j] = 0;
                    _pending[i][j] = 0;
                    _alive[i][j] = false;
                }
            }
            
            
            _dirty = new Array(GRID_COUNT+1);
            for (var c:uint = 0; c < GRID_COUNT; c++) {
                for (var d:uint = 0; d < GRID_COUNT; d++) {
                    _dirty[c] = new Array(GRID_COUNT+1);
                    _dirty[c][d] = false;
                }                
            }
            
            
            // Filled block
            for (var n:int = 0; n < WIDTH / 2; n++) {
                for (var m:int = 0; m < WIDTH / 2; m++) {
                    change(WIDTH / 4 + n, WIDTH / 4 + m, true);
                }
            }
            
            _startTime = new Date();
            _fps = new TextField();
            _fps.textColor = 0xFFFF0000;
            stage.addChild(_fps);
        }
        
        
        public function update(evt:Event=null):void {
            updatePending();
            updateCells();
        }
        
        public function updatePending():void {
            for (var gx:uint = 0; gx < GRID_COUNT; gx++) {
                for (var gy:uint = 0; gy < GRID_COUNT; gy++) {
                    if (_dirty[gx][gy]) {
                        var gxb:uint = gx * GRID_WIDTH;
                        var gyb:uint = gy * GRID_HEIGHT;
                        var dirty:Boolean = false;
                        for (var n:uint=0; n < GRID_WIDTH; n++) {
                            for (var m:uint=0; m < GRID_HEIGHT; m++) {
                                dirty = applyPending(gxb + n, gyb + m) || dirty;
                            }
                        }
                        _dirty[gx][gy] = dirty;
                    }
                }
            }
        }
        
        public function updateCells():void {
            for (var gx:uint = 0; gx < GRID_COUNT; gx++) {
                for (var gy:uint = 0; gy < GRID_COUNT; gy++) {
                    if (_dirty[gx][gy]) {
                        var gxb:uint = gx * GRID_WIDTH;
                        var gyb:uint = gy * GRID_HEIGHT;
                        for (var n:uint=0; n < GRID_WIDTH; n++) {
                            for (var m:uint=0; m < GRID_HEIGHT; m++) {
                                updateCell(gxb + n, gyb + m);
                            }
                        }
                    }
                }
            }
            
            var newTime:Date = new Date();
            var fps:Number = 1000 / (newTime.getTime() - _startTime.getTime());
            _fps.text = String(Math.floor(fps * 100) / 100);
            _startTime = newTime;
        }
        
        public function applyPending(x:int, y:int):Boolean {
            if (_pending[x][y] != 0) {
                _cells[x][y] += _pending[x][y];
                _pending[x][y] = 0;
                return true;
            }
            return false;
        }
        
        public function updateCell(x:int, y:int):void {
            var cell:uint = _cells[x][y];
            
            var oldState:Boolean = _alive[x][y];
            var newState:Boolean = false;
            if (cell == 3 || (oldState && cell == 2)) {
                newState = true;
            }
            
            if (oldState != newState) {
                change(x, y, newState);
            }
        }
        
        public function change(x:int, y:int, newState:Boolean):void {
            var neighborDelta:int = -1;
            if (newState) {
                _alive[x][y] = true;
                neighborDelta = 1;
                _bitmapData.setPixel(x, y, 0xFFFFFFFF);
            } else {
                _alive[x][y] = false;         
                _bitmapData.setPixel(x, y, 0);
            }
            
            
            var xp1:int = x + 1;
            var yp1:int = y + 1;
            changeNeighborCount(xp1, yp1, neighborDelta);
            changeNeighborCount(x, yp1, neighborDelta);
            changeNeighborCount(xp1, y, neighborDelta);
            var xm1:int = x - 1;
            changeNeighborCount(xm1, yp1, neighborDelta);
            changeNeighborCount(xm1, y, neighborDelta);
            
            var ym1:int = y - 1;
            changeNeighborCount(xm1, ym1, neighborDelta);
            changeNeighborCount(xp1, ym1, neighborDelta);
            changeNeighborCount(x, ym1, neighborDelta);
            markDirty(xp1, yp1);
            markDirty(xp1, ym1);
            markDirty(xm1, ym1);
            markDirty(xm1, yp1);
            
            
        }
        
        public function changeNeighborCount(x:int, y:int, delta:int):void {
            if (x < 0 || y < 0) {
                return;
            }
            _pending[x][y] += delta;                
        }
        
        public function markDirty(x:int, y:int):void {
            // Don't need a negative check here because -1 * GRID_WIDTH_MUL will round up to 0.
            
            var gx:int = x * GRID_WIDTH_MUL;
            var gy:int = y * GRID_HEIGHT_MUL;
            _dirty[gx][gy] = true;
        }

    }
}