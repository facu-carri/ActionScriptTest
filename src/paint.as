package 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.qb9.flashlib.color.Color;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.filters.GlowFilter;
	import flash.filters.ColorMatrixFilter;
	import assets.bar;
	import flash.display.Stage;
	/**
	 * ...
	 * @author carr
	 */
	public class paint extends Sprite
	{
		
		private var barAsset:bar = new bar();
		
		public function paint() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init():void 
		{
			var mc:MovieClip = barAsset as MovieClip;
			this.addChild(mc);
			paintMC(mc);
		}
		
		private function paintMC(mc:MovieClip):void 
		{
			var matrix:Array = new Array();
			var filters:Array = [];
			matrix = matrix.concat([0, 2, 0, 0, 0]);// red
			matrix = matrix.concat([0, 1, 0, 0, 0]);// green
			matrix = matrix.concat([0, 0, 0, 0, 0]);// blue
			matrix = matrix.concat([0, 0, 0, 1, 0]);// alpha
			filters.push(new ColorMatrixFilter(matrix));
			mc.filters = filters;
		}
	}
}