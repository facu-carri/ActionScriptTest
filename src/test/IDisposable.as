package test 
{
	/** Interface for all classes that can be disposed of (for garbage collection). */
	public interface IDisposable
	{
		/** Release all resources used by the instance. */
		function dispose():void;
	}
}
