package test 
{
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;

	/** Common interface for all loader classes. */
	public interface ILoader extends IEventDispatcher
	{
		/**
		 * Should also dispatch these events
		 *	- complete
		 *	- httpStatus
		 *	- ioError
		 *	- open
		 *	- progress
		 *	- securityError
		 */ 
		
		function close() : void;
		function loadURL(url:URLRequest) : void;
		function getData() : *;
		function getBytesLoaded() : uint;
		function getBytesTotal() : uint;
		
		function getDataFormat() : String;
		function setDataFormat(format:String) : void;
	}
}
