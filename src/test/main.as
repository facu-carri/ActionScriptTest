package test 
{
	import com.qb9.flashlib.config.Settings;
	import com.qb9.flashlib.tasks.Func;
	import com.qb9.flashlib.tasks.Sequence;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import com.qb9.flashlib.tasks.Parallel;
	import com.qb9.flashlib.net.LoadFile;
	import com.qb9.flashlib.net.LoadFileParsers;
	import com.qb9.flashlib.net.LoadFileFormat;
	import flash.text.TextField;
	import com.qb9.flashlib.utils.ObjectUtil;
	import com.adobe.serialization.json.JSON;
	/**
	 * ...
	 * @author ...
	 */
	public class main extends Sprite
	{
		
		//public var settings:Settings = new Settings();
		
		public function main()
		{
			start()
		}
		
		private function start():void
		{
			LoadFileParsers.registerParser(LoadFileFormat.JSON, com.adobe.serialization.json.JSON.decode);
			var settingsFile:LoadFile = new LoadFile('https://cdn-ar.mundogaturro.com/juego/cfgs/settings.json', LoadFileFormat.JSON);
			settings.addFile(settingsFile);
			
			var parallel:Parallel = new Parallel();
			parallel.add(settingsFile);
			
			new Sequence(parallel, new Func(mergeSettings)).start();
		}
		
		private function mergeSettings() : void
		  {
			 //settings = Settings(ObjectUtil.copy(settings));
		  }
		
		private function end():void 
		{
			trace('nice')
		}
	}

}