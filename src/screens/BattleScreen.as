package screens {

    import battle.Mech;
    import battle.Team;
    
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    
    import gameobjects.GameObject;
    import gameobjects.GameObjectManager;
    
    import particle.Explosion;
    
    public class BattleScreen extends Screen {
        
        public static const MAX_WIDTH:int = 1000;
        public static const MAX_HEIGHT:int = 1000;

        public static const PLAYER_TEAM:String = "player_team";
        public static const ENEMY_TEAM:String = "enemy_team";
        
        private var _activeMech:Mech;
        private var _background:GameObject;

        private var _teams:Object;
        private var _playerTeamId:String;

        public function BattleScreen() {
            _teams = new Object();
        }
        
        override public function initialize():void {
            _background = new GameObject();
            _background.sortOrder = 10;
            _background.graphics.beginFill(0xCD853F);
            _background.graphics.drawRect(0, 0, 1000, 1000);
            _background.graphics.endFill();
            GameObjectManager.singleton.addChild(_background);

            var team:Team = new Team(PLAYER_TEAM);
            var startingX:int = 10;
            var startingY:int = 10;
            for (var i:int = 0; i < 4; i++) {
                var mech:Mech = new Mech(this);
                mech.teamId = PLAYER_TEAM;
                GameObjectManager.singleton.addChild(mech);
                mech.setPosition(startingX, startingY);
                startingY += 200;
                team.addMech(mech);
            }
            addTeam(team, true);

            var enemies:Team = new Team(ENEMY_TEAM);
            startingX = 900;
            startingY = 10;
            for (i = 0; i < 4; i++) {
                mech = new Mech(this);
                mech.teamId = ENEMY_TEAM;
                GameObjectManager.singleton.addChild(mech);
                mech.setPosition(startingX, startingY);
                startingY += 200;
                enemies.addMech(mech);
            }
            addTeam(enemies, false);
            
            GameObjectManager.singleton.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
            GameObjectManager.singleton.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
        }
        
        override public function shutDown():void {
            GameObjectManager.singleton.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            GameObjectManager.singleton.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
        
            GameObjectManager.singleton.removeChild(_background);
        }
        
        public function mouseDownHandler(evt:MouseEvent):void {
            trace("mouseDown", evt.stageX, evt.stageY, evt.localX, evt.localY);
        }
        
        public function mouseUpHandler(evt:MouseEvent):void {
            trace("mouseUp", evt.stageX, evt.stageY, evt.localX, evt.localY);
            // check if the player clicked on one of his mechs
            if (_teams[playerTeamId]) {
                for each (var mech:Mech in _teams[playerTeamId].mechs) {
                    if ((evt.stageX > mech.x && evt.stageX < mech.x + mech.width) 
                    && (evt.stageY > mech.y && evt.stageY < mech.y + mech.height)) {
                        if (mech.teamId == playerTeamId) {
                            activeMech = mech;
                            return;
                        }
                    }
                }
            }
            
            // move the selected mech to that location
            if (_activeMech) {
                _activeMech.moveTo(evt.stageX, evt.stageY);
            }
        }
        
        public function set activeMech(val:Mech):void {
            trace("setting activeMech:", val.guid);
            if (_activeMech) {
                _activeMech.removeSelectionHighlight();
            }
            _activeMech = val;
            _activeMech.addSelectionHighlight();
        }

        public function get activeMech():Mech {
            return _activeMech;
        }
        
        public function addTeam(team:Team, isPlayerTeam:Boolean = false):void {
            _teams[team.teamId] = team;           
            if (isPlayerTeam) {
                if (_playerTeamId) {
                    throw new Error("[BattleScreen] Player team already set:" + _playerTeamId);
                } else {
                    _playerTeamId = team.teamId;
                }
            }
        }
        
        public function get playerTeamId():String {
            return _playerTeamId;
        }
    }
}