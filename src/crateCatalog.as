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
	import flash.external.ExternalInterface;
	import flash.events.TextEvent;
	import flash.text.TextFieldType;
	import flash.utils.setTimeout;
	import com.qb9.flashlib.math.Random;
	
	public class crateCatalog extends Sprite 
	{
		private var FIELD_HEIGHT:uint = 800;
		private var FIELD_MAX_WIDTH:uint = 800;
		private var field:TextField;
		
		public function crateCatalog() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			field = getTextfield();
			stage.addChild(field);
			field.addEventListener(TextEvent.TEXT_INPUT, deelay);
		}
		
		private function deelay(e:TextEvent = null):void 
		{
			setTimeout(textInput, 100);
		}
		
		private function textInput():void 
		{
			var text:String = field.text;
			var split:Array = text.split(String.fromCharCode(13));
			if (split.length > 1){
				trace("----------------------------------------------------------");
				split.sort(Array.DESCENDING);
				for (var i:int = 0; i < split.length; i++){
					var obj:Array = String(split[i]).split('.');
					trace('   <item name="' + split[i] + '" price="' + (obj[1].length * (Random.randint(10, 20))).toString() + '.0" ' + 'vip="' + (Random.randint(0,100) <= 60 ? "true" : "false") + '">' + obj[1].toLocaleUpperCase() + '</item>');
				}
			}
		}
		
		private function makeFormat():TextFormat
		{
			var fmt:TextFormat = new TextFormat('Verdana', 12, Color.BLACK);
			fmt.leftMargin = 10;
			fmt.leading = 2;
			return fmt;
		}
		
		public function getTextfield():TextField
		{
			field = new TextField();
			field.defaultTextFormat = makeFormat();
			field.multiline = true;
			field.wordWrap = true;
			field.type = TextFieldType.INPUT;
			field.width = 800;
			field.height = 800;
			field.autoSize = getAutosize();
			field.embedFonts = false;
			field.selectable = false;
			field.selectable = true;
			field.border = true;
			return field;
		}
		
		protected function getAutosize():String
		{
			return TextFieldAutoSize.CENTER;
		}
	}
}