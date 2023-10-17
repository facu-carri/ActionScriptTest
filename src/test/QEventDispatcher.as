package test 
{
	import com.qb9.flashlib.interfaces.IDisposable;
	import com.qb9.flashlib.utils.ArrayUtil;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	
	/**
	 * Enhanced EventDispatcher. Features:
	 *
	 * <ul>
	 *   <li>Weak references used by default.</li>
	 *   <li><code>dispose()</code> method, that clears all registered listeners.</li>
	 * </ul>
	 */
	public class QEventDispatcher extends EventDispatcher implements IDisposable
	{
		protected var listeners:Object;
		
		public function QEventDispatcher(target:IEventDispatcher = null)
		{
			super(target);
			this.listeners = {};
		}

		/**
		 * Shortcut for dispatching a <code>QEvent</code> instance.
		 *
		 * @see QEvent
		 */
		public function dispatch(type:String, data:* = null):Boolean
		{
			if (!this.hasEventListener(type))
				return true;
			return this.dispatchEvent(new QEvent(type, data));
		}

		/** @inheritDoc */
		public override function addEventListener(type:String, fn:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true):void
		{
			// Native binding
			super.addEventListener(type, fn, useCapture, priority, useWeakReference);
			
			// Store it
			if (this.listeners[type])
			{
				if (!ArrayUtil.contains(this.listeners[type], fn))
					this.listeners[type].push(fn);
			}
			else
			{
				this.listeners[type] = [fn];
			}
		}
		
		/** @inheritDoc */
		public override function removeEventListener(type:String, fn:Function, useCapture:Boolean = false) : void
		{
			// Native binding
			super.removeEventListener(type, fn, useCapture);
			
			var handlers:Array = this.listeners[type];
			if (!handlers) return;
			
			ArrayUtil.removeElement(handlers, fn);
			
			// Clean properly
			if (handlers.length == 0)
			{
				delete this.listeners[type];
			} 
		}
		
		/** Remove all registered event listeners. */
		public function dispose() : void
		{
			for (var type:String in this.listeners)
			{
				var handlers:Array = this.listeners[type];
				// Loop backwards as they get removed
				while (handlers && handlers.length > 0)
					removeEventListener(type, handlers[handlers.length - 1]); 
			}
		}
	}
}
