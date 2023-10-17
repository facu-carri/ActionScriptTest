package test 
{
	import com.qb9.flashlib.events.QEventDispatcher;
	import flash.external.ExternalInterface;
	
	/**
	 * Base class for tasks.
	 */
	public class Task extends QEventDispatcher implements ITask
	{
		protected var _running:Boolean;
		protected var _elapsed:uint;

		public function Task()
		{
			_elapsed = 0;
			_running = false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get running():Boolean
		{
			return _running;
		}

		/**
		 * @inheritDoc
		 */
		public function get elapsed():uint
		{
			return _elapsed;
		}

		/**
		 * @inheritDoc
		 */
		public function start():void
		{
			if (running) return;
			_running = true;
			this.dispatch(TaskEvent.STARTED);
		}
		
		/**
		 * @inheritDoc
		 */
		public function stop():void
		{
			if (!running) return;
			_running = false;
			this.dispatch(TaskEvent.STOPPED);
		}
		
		/**
		 * @inheritDoc
		 */
		public override function dispose():void
		{
			if (running)
				stop();
			super.dispose();
		}
		
		/** @inheritDoc */
		public function update(milliseconds:uint):void
		{
			_elapsed += milliseconds;
			this.dispatch(TaskEvent.UPDATE, {milliseconds:milliseconds});
		}

		protected function taskComplete():void
		{
			this.stop();
			this.dispatch(TaskEvent.COMPLETE);
		}

		/** @inheritDoc */
		public function clone():ITask
		{
			return new Task();
		}

		protected function updateSubtask(task:ITask, milliseconds:uint):uint
		{
			var prev:uint = task.elapsed;
			task.update(milliseconds);
			return task.elapsed - prev;
		}
		
		/**
		 * Shortcut for dispatching a <code>TaskEvent</code> instance.
		 *
		 * @see TaskEvent
		 */
		public override function dispatch(type:String, data:* = null):Boolean
		{
			if (!this.hasEventListener(type))
				return true;
			return this.dispatchEvent(new TaskEvent(type, data));
		}
	}
}
