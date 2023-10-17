package test 
{
	/** Utility functions to operate on Array instances. */
	public class ArrayUtil
	{
		/**
		 * Remove an element from an array.
		 *
		 * @return The object removed; or <code>null</code> if it is not found.
		 */ 
		public static function removeElement(array:Array, elem:Object):Object
		{
			var i:int = array.indexOf(elem);
			if (i != -1)
				return array.splice(i, 1)[0];
			return null;
		}
		
		/**
		 * Adds without duplicates.
		 * @param data The array with duplicate values.
		 */ 
		public static function addUnique(arr:Array, value:*):void
		{
			if (!contains(arr, value))
				arr.push(value);
		}
		
		/**
		 * Given an array with duplicate values, returns an array 
		 * with no duplicates.
		 * The <i>data</i> is not changed.
		 * 
		 * @param data The array with duplicate values.
		 */ 
		// TODO: This is currently O(n²), can be turn into O(2n) by using a Dictionary
		public static function removeDuplicates(data:Array):Array
		{
			var unique:Array = new Array();
			
			for (var i:int=0, l:int = data.length; i<l; i++)
				addUnique(unique, data[i]);
			
			return unique;
		}
		
		/**
		 * Returns a random index within the array boundaries
		 */
		public static function chooseIndex(values:Array):int
		{
			return Math.random() * values.length;
		}
		
		/**
		 * Remove a random element from the array and return it.
		 */
		public static function popChoice(values:Array):Object
		{
			return values.splice(chooseIndex(values),1)[0];
		}
		
		/**
		 * Return a random element from the array.
		 */
		public static function choice(values:Array):Object
		{
			return values[chooseIndex(values)];
		}
		
		/**
		 * Return a random element with probabilities from the array.
		 */
		public static function choiceWithProbability(values:Array, probabilities:Array):Object
		{
			var n:Number = sum(probabilities) * Math.random();
			for (var i:int = 0; i < probabilities.length; i++)
			{
				n -= probabilities[i];
				if (n < 0)
					return values[i];
			}
			return null;
		}
		
		/**
		 * Return a new array with the elements in random order.
		 */
		public static function shuffle(arr:Array):Array 
		{
			var shuffled:Array = [];
			arr = arr.slice();
			
			while (arr.length > 0)
				shuffled.push(popChoice(arr));
			return shuffled;
		}
		
		/**
		 * Return whether an array contains an element.
		 */
		public static function contains(arr:Array, obj:Object):Boolean
		{
			if (!arr) return false;
			return arr.indexOf(obj) !== -1;
		}
		
		/**
		 * Returns whether 2 arrays have the same elements, in the same order.
		 */
		public static function equal(arr1:Array, arr2:Array):Boolean
		{
			var l:int = arr1.length;
			if (arr2.length !== l)
				return false;

			while (l--)
				if (arr1[l] !== arr2[l])
					return false;
			return true;
		}
		

		/**
		 * Adds a set of elements (inline) to an array (x5 faster than foreach+push) 
		 */
		public static function append(target:Array, src:Object):void
		{
			var values:Array = src is Array ? src as Array : ObjectUtil.values(src);
			target.push.apply(target, values);
		}

		
		/**
		 * Flattens an array into one of 1D
		 */
		public static function flatten(arr:Array):Array
		{
			var flat:Array = [];
			for each(var value:* in arr)
			{
				if (value is Array)
					append(flat, flatten(value));
				else
					flat.push(value);
			}
			return flat;
		}
		
		/**
		 * Replaces one object with another
		 */
		public static function replace(arr:Array, old:Object, repl:Object):void
		{
			if (contains(arr,old))
				arr[arr.indexOf(old)] = repl;
		}
		
		/**
		 * Sums all the numbers within an array
		 */
		public static function sum(arr:Array):Number
		{
			var s:Number = 0;
			for each (var v:Number in arr)
				s += v;
			return s;
		}
	}
}
