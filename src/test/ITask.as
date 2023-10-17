package test 
{
	import com.qb9.flashlib.interfaces.IDisposable;
	import com.qb9.flashlib.interfaces.IUpdateable;
	import flash.events.IEventDispatcher;

	/**
	 * Interface for all tasks.
	 */
	public interface ITask extends IDisposable, IUpdateable, IEventDispatcher
	{
		/**
		 * Returns whether or not the task is currently in execution.
		 */
		function get running():Boolean;

		/**
		 * Returns the elapsed time, in milliseconds.
		 */
		function get elapsed():uint;

		/**
		 * Start execution of the task.
		 */
		function start():void;
		
		/**
		 * Stop execution of the task.
		 *
		 * Call <code>start()</code> to resume execution.
		 */
		function stop():void;
		
		/**
		 * Clone the task. This method will only be called before the task is started.
		 */
		function clone():ITask;
	}
}
