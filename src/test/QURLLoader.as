package test 
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/** Wrapper for the URLLoader class that implements the ILoader interface. */
	internal class QURLLoader extends URLLoader implements ILoader
	{
		public function QURLLoader(request:URLRequest=null)
		{
			super(request);
		}
		
		public function loadURL(url:URLRequest):void
		{
			//log('load url')
			load(url);
			//log('load url end')
		}
		
		public function getData() : *
		{
			return LoadFileParsers.parse(dataFormat,data);
		}
		
		public function getBytesLoaded():uint
		{
			return bytesLoaded;
		}
		
		public function getBytesTotal():uint
		{
			return bytesTotal;
		}
		
		public function getDataFormat():String
		{
			return dataFormat;
		}
		
		public function setDataFormat(format:String):void
		{
			dataFormat = format;
		}
	}
}
