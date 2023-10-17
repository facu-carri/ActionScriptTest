package
{
	import com.qb9.flashlib.interfaces.IDisposable;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	import flash.external.ExternalInterface;
	
	public class htmlTest extends Sprite implements IDisposable
	{
		public function htmlTest()
		{
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			this.addEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		private function added(e:Event):void
		{
			consoleLog('added swf');
			if (ExternalInterface.available)
			{
				consoleLog('Add listener');
				ExternalInterface.addCallback("sendToMMO", receivedFromJavaScript);
			}
		}
		
		private function consoleLog(str:String):void
		{
			if (ExternalInterface.available)
			{
				ExternalInterface.call('console.log', '>>', str);
				ExternalInterface.
			}
		}
		
		private function receivedFromJavaScript(data:Object):void
		{
			consoleLog('Received From JavaScript');
			ExternalInterface.addCallback("sendToMMO", null);
		}
		
		public function dispose():void
		{
			
		}
	}
}