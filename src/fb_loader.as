package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.external.ExternalInterface;

	public class fb_loader
	{
		public static function load(parent:Sprite, id:String=null):void
		{
			if (id == null) {
				id = ExternalInterface.call('random_fb_id');
				if (id == null) {
					trace("External call failed");
					id = "1189440211";
				}
			}
			var myLoader:Loader = new Loader();
			myLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressStatus);
			myLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderReady);
			
			var fileRequest:URLRequest = new URLRequest("http://graph.facebook.com/" + id + "/picture");
			myLoader.load(fileRequest);
			
			function onProgressStatus(e:ProgressEvent):void {   
				// this is where progress will be monitored     
				trace(e.bytesLoaded, e.bytesTotal); 
			}
			
			function onLoaderReady(e:Event):void {     
				// the image is now loaded, so let's add it to the display tree!
				var container:GameObject = new GameObject();
				container.sortOrder = 100;
				container.addChild(myLoader);
				parent.addChild(container);
			}
		}
	}
}