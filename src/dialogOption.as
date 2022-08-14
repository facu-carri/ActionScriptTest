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
		
		public function dialogOption() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		import flash.utils.setTimeout;
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//api.userAvatar.addEventListener('wrsoeStartedMoving', dispose);
			//if (ExternalInterface.available) ExternalInterface.call("console.log", "HELLO");
			this.options = "Pedir perm-Pedir discul-Comprarasd tet ete ettet-a-a-testosteronaliquida asdasdsad entucolaasdasdasdasddkjgfdogjfdiogja-a-odifjgifogjfoigjoigjgofjgfogjf".split('-');
			this.userAnswers = "Por favor, Narciso, ¿podrías prestarme las tijeras?-Perdón, Narciso, actué muy rápido y no pensé las cosas- ".split('-');
			this.npcAnswers = "talk1-talk2-talk3".split('-');
			var aval:Boolean = ExternalInterface.available;
			this.title = "ExternalInterface Avaliable? " + aval.toString();
			var balloonOptions:MovieClip = new MovieClip;
			this.addChild(balloonOptions);
			
			var field:TextField = createTitle(title ? title : 'HABLAR SOBRE...');
			balloonOptions.addChild(field);
			
			var btns:MovieClip = new MovieClip();
			for (var i:int = 0; i < options.length; i++){
				var option:MovieClip = createOptionWithText(options[i], i, field.textHeight + 11);
				btns.addChild(option);
			}
			balloonOptions.addChild(btns);
			
			var balloonBg:Shape = createShape(Color.BLACK, 0, 0, BALLOON_MAX_WIDTH + 24, BALLOON_MAX_HEIGTH + 12, 0.8);
			balloonOptions.addChildAt(balloonBg, 0);
			var f:Function = function():void{
				var t2:TextField = createTextField(ExternalInterface.available.toString(), Color.PURPLE);
				balloonOptions.addChild(t2);
				if (ExternalInterface.available){
					ExternalInterface.call("console.log", "YourString");
				}
				//ExternalInterface.call("console.log", "hello world");
			}
			setTimeout(f, 3000);
			//balloonOptions.y -= BALLOON_MAX_HEIGTH;
		}
		
		private function createTitle(text:String):TextField
		{
			var field:TextField = createTextField(text, Color.WHITE);
			field.y += 5;
			BALLOON_MAX_HEIGTH += field.textHeight;
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
			var field:TextField = createTextField(text, Color.BLACK);
			var btn:MovieClip = generateOptionMc(field.textWidth + 12, field.textHeight);
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
			BALLOON_MAX_WIDTH = Math.max(BALLOON_MAX_WIDTH, width);
		}
		
		private function createTextField(text:String, color:uint):TextField 
		{
			var field:TextField = new TextField();
			field = getTextfield(field);
			decorateTextField(text.toUpperCase(), field, color);
			field.x += 3;
			field.y -= 1
			field.mouseEnabled = false;
			calculateMax(field.textWidth);
			return field;
		}
		
		private function decorateTextField(string:String, field:TextField, color:uint) : void
        {
            field.defaultTextFormat = new TextFormat('Cooper', 12, color);
            field.text = string;
        }
		
		public function getTextfield(field:TextField):TextField
		{
			field.multiline = true;
			field.wordWrap = true;
			field.width = FIELD_MAX_WIDTH;
			field.height = FIELD_HEIGHT;
			field.autoSize = getAutosize();
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