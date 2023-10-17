package test 
{
	import flash.events.Event;
	
	/**
	 * Custom cancelable Event containing a generic <code>data</code> attribute.
	 *
	 * @see QEventDispatcher.dispatch()
	 */
	public class QEvent extends Event
	{
		public var data:*;
		
		public function QEvent(type:String, data:* = null)
		{
			super(type, false, true);
			this.data = data == null ? {} : data;
		}

		/** @inheritDoc */
		public override function clone():Event
		{
			return new QEvent(type, data);
		}
	}
}
