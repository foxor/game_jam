package rpg
{
	import flash.external.ExternalInterface;

	public class Friend
	{
		public var id:int;
		public function Friend(id:int)
		{
			this.id = id;
		}
		
		public static function getRandomId():String {
			var id:String = ExternalInterface.call('random_fb_id');
			if (id == null) {
				trace("External call failed");
				id = "1189440211";
			}
			return id;
		}
	}
}