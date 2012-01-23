package battle {
    public class Team {
        
        private var _teamId:String;
        private var _mechs:Array;
        
        public function Team(teamId:String) {
            _teamId = teamId;
            _mechs = new Array();
        }
        
        public function addMech(newMech:Mech):void {
            newMech.teamId = teamId;
            _mechs.push(newMech);
        }
        
        public function get teamId():String {
            return _teamId;
        }

        public function get mechs():Array {
            return _mechs;
        }
    }
}