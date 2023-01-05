package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.setInterval;
	
	public class test extends MovieClip
	{
		
		public function test() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			var str:String = 'carpets.alfombraPeluda1';
			trace('char: ' + str.charAt(0));
			trace('char id: ' + str.charCodeAt(0));
		}
		
		/*private function repeatThis(e:Event = null):void 
		{
			trace(Math.round(Math.random() * 3) + 1);
		}*/
	}
}