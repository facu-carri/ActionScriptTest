package
{
	import assets.GaturroMC;
	import assets.vipMedal;
	import com.qb9.flashlib.movieclip.MovieClipManager;
	import farm.AceleradorSinPasaporte;
	import flash.display.DisplayObject;
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
	import com.qb9.flashlib.lang.foreach;
	import mx.logging.Log;
	
	public class dialogOption extends Sprite 
	{
		private var FIELD_HEIGHT:uint = 100;
		private var FIELD_MAX_WIDTH:uint = 180;
		private var BALLOON_MAX_WIDTH:Number = 0;
		private var BALLOON_MAX_HEIGTH:Number = 0;
		private var BTN_PREV_Y:Number = 0;
		private var options:Array;
		private var userAnswers:Array;
		private var npcAnswers:Array;
		private var title:String;
		private var allOptions:Array = [];
		
		public function dialogOption() 
		{
			bye();
			bye();
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		import flash.utils.setTimeout;
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			/*var m:MovieClip = new vipMedal();
			var a:AppAlarmClockSC = new AppAlarmClockSC;
			var g:GaturroMC = new GaturroMC;
			var asd:AceleradorSinPasaporte = new AceleradorSinPasaporte;
			var dda:* = Log.isDebug();*/
			//api.userAvatar.addEventListener('wrsoeStartedMoving', dispose);
			//if (ExternalInterface.available) ExternalInterface.call("console.log", "HELLO");
			//var g:Gaturro = new Gaturro(null);
			this.options = "SI-NO".split('-');
			this.userAnswers = "Por favor, Narciso, ¿podrías prestarme las tijeras?-Perdón, Narciso, actué muy rápido y no pensé las cosas- ".split('-');
			this.npcAnswers = "talk1-talk2-talk3".split('-');
			var aval:Boolean = ExternalInterface.available;
			var balloonOptions:MovieClip = new MovieClip;
			this.addChild(balloonOptions);
			
			var btns:MovieClip = new MovieClip();
			for (var j:int = 0; j < options.length; j++){
				createTextField(options[j]);
			}
			
			var field:TextField = createTitle(title ? title : '¿JURAS LEALTAD ETERNA?');
			balloonOptions.addChild(field);
			
			for (var i:int = 0; i < options.length; i++){
				var option:MovieClip = createOptionWithText(options[i], i, field.textHeight + 11);
				btns.addChild(option);
			}
			balloonOptions.addChild(btns);
			field.width = BALLOON_MAX_WIDTH + 6;
			var balloonBg:Shape = createShape(Color.BLACK, 0, 0, BALLOON_MAX_WIDTH + 12, BALLOON_MAX_HEIGTH + 12, 0.8);
			balloonOptions.addChildAt(balloonBg, 0);
			//balloonOptions.y -= BALLOON_MAX_HEIGTH;
		}
		
		private function bye():void 
		{
			for (var i:int = 0; i < this.numChildren; i++){
				var thing:DisplayObject = this.getChildAt(i) as DisplayObject;
				if (thing.name.indexOf('instance') != -1){
					this.removeChild(thing);
				}
			}
		}
		
		private function call(txt:String):void 
		{
			if(ExternalInterface.available)
				ExternalInterface.call('console.log', txt);
		}
		
		private function createTitle(text:String):TextField
		{
			var field:TextField = createTextField2(text);
			BALLOON_MAX_HEIGTH += field.textHeight;
			return field;
		}
		
		private function createTextField2(text:String):TextField 
		{
			var field:TextField = new TextField();
			field = getTextfield(field, FIELD_MAX_WIDTH);
			decorateTextField(text.toUpperCase(), field, Color.BLACK);
			field.x += 3;
			field.y += 4;
			field.mouseEnabled = false;
			calculateMax(field.textWidth);
			return field;
		}
		
		private function over(e:MouseEvent):void 
		{
			var opt:MovieClip = e.currentTarget as MovieClip;
			applyFilters(opt);
		}
		
		private function out(e:MouseEvent):void 
		{
			var opt:MovieClip = e.currentTarget as MovieClip;
			applyFilters(opt, false);
		}
		
		private function click(e:MouseEvent):void 
		{
		}
		
		private function applyFilters(mc:MovieClip, bol:Boolean = true):void
		{
			var filters:Array = new Array();
			if(bol){
				filters.push(new GlowFilter(Color.WHITE, 0.7, 10, 10, 1));
			}
			mc.filters = filters;
		}
		
		private function createOptionWithText(text:String, i:int, fHeight:int):MovieClip
		{
			var option:MovieClip = new MovieClip();
			var field:TextField = createTextField(text, Color.BLACK, true);
			var btn:MovieClip = generateOptionMc(BALLOON_MAX_WIDTH, field.textHeight);
			btn.name = 'btn_' + i;
			BALLOON_MAX_HEIGTH += btn.height + 6;
			btn.addEventListener(MouseEvent.ROLL_OVER, over);
			btn.addEventListener(MouseEvent.MOUSE_OUT, out);
			btn.addEventListener(MouseEvent.CLICK, click);
			option.addChild(btn);
			option.addChild(field);
			if (i != 0){
				BTN_PREV_Y += btn.height + 6;
			}
			option.y = (btn.height > 18 ? BTN_PREV_Y - 14 * (Math.round(btn.height / 14) - 1) : BTN_PREV_Y) + fHeight;
			option.x = 5;
			return option;
		}
		
		private function calculateMax(width:Number):void
		{
			BALLOON_MAX_WIDTH = Math.max(BALLOON_MAX_WIDTH, width + 12);
		}
		
		private function createTextField(text:String, color:uint = Color.BLACK, calculateWidth:Boolean = false):TextField 
		{
			var field:TextField = new TextField();
			field = getTextfield(field, calculateWidth ? BALLOON_MAX_WIDTH : FIELD_MAX_WIDTH);
			decorateTextField(text.toUpperCase(), field, color);
			field.x += 3;
			field.y -= 1
			field.mouseEnabled = false;
			if(!calculateWidth) calculateMax(field.textWidth);
			return field;
		}
		
		private function decorateTextField(string:String, field:TextField, color:uint) : void
        {
            field.defaultTextFormat = new TextFormat('Cooper', 12, color, null, null, null, null, null, 'center');
            field.text = string;
        }
		
		public function getTextfield(field:TextField, width:Number):TextField
		{
			field.multiline = true;
			field.wordWrap = true;
			field.width = Math.min(width, FIELD_MAX_WIDTH);
			field.height = FIELD_HEIGHT;
			field.autoSize = getAutosize();
			field.border = true; field.borderColor = Color.BLUE;
			field.embedFonts = false;
			field.selectable = false;
			return field;
		}
		
		protected function getAutosize():String
		{
			return TextFieldAutoSize.CENTER;
		}
		
		private function generateOptionMc(width:int = 50, height:int = 50):MovieClip 
		{
			var opt:MovieClip = new MovieClip;
			var btnFront:Shape = createShape(Color.YELLOW, 0, 0, width, height, 1, 10);
			var btnBack:Shape = createShape(0xD77B00, 3, 3, width, height, 1, 10)
			opt.addChild(btnFront);
			opt.addChildAt(btnBack, 0);
			return opt
		}
		
		private function createShape(color:uint, x:int = 0, y:int = 0, width:int = 0, height:int = 0, alpha:Number = 1, curv:int = 20) : Shape
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(color, alpha);
			shape.graphics.drawRoundRect(x, y, width, height, curv);
			shape.graphics.endFill();
			return shape;
		}
	}
}