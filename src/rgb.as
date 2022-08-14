package
{
	import com.qb9.flashlib.math.Random;
	import Math;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.qb9.flashlib.color.Color;
	import flash.display.Stage;
	
	public class rgb extends MovieClip
	{
		//vars
		
		public function rgb():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function intToHex(colorNumber:uint):String
		{
			var toHex:Function = function(n:*):String {
				n = n.toString(16);
				var arr:Array;
				return n.length >= 2 ? n : new Array(2 - n.length + 1).join('0') + n;
			}
			var r:String = toHex(Math.floor( Math.floor(colorNumber / 256) / 256 ) % 256);
			var	g:String = toHex(Math.floor( colorNumber / 256 ) % 256);
			var	b:String = toHex(colorNumber % 256);
			return '#' + r + g + b; 
		}
		
		private function init(e:Event = null):void 
		{
			var c:Color = Color.fromRGB(255, 255, 255);
			trace(intToHex(c.hex));
		}
	}
}