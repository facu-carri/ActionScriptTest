package test 
{
	import com.qb9.flashlib.events.QEvent;
	import flash.events.Event;

	/** Event dispatched by an ITask instance. */
	public class TaskEvent extends QEvent
	{
		public static const COMPLETE:String = "taskComplete";
		public static const STARTED:String = "taskStarted";
		public static const STOPPED:String = "taskStopped";
		public static const UPDATE:String = "taskUpdate";
		
		public function TaskEvent(type:String, data:* = null)
		{
			super(type, data);
		}

		public override function clone():Event
		{
			return new TaskEvent(type, data);
		}
	}
}
