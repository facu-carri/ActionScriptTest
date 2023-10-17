package test 
{
	/** Interface for all classes that must be updated as time passes. */
	public interface IUpdateable
	{
		/**
		 * Update the object.
		 *
		 * @param milliseconds Amount of time that passed since the last call.
		 *                     Use (1000.0 / stage.frameRate) if calling once per frame.
		 */
		function update(milliseconds:uint):void
	}
}
