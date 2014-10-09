package progen.lsystem;

/**
 * ...
 * @author P Svilans
 */

class LSystem
{
	
	public var initial:String;
	public var current:String;
	
	private var rules:Map<String, String>;
	
	/**
	 * Creates an LSystem that will start with the initial string.
	 * @param	initial The initial state of the LSystem.
	 */
	
	public function new(initial:String):Void
	{
		this.initial = initial;
		current = initial;
		
		rules = new Map<String, String>();
	}
	
	/**
	 * Add a rule. When <rule> is found in the current string, it will be replaced by <result>
	 * @param	rule Character to replace.
	 * @param	result String to replace character with.
	 */
	public inline function add(rule:String, result:String):Void
	{
		rules.set(rule, result);
	}
	
	/**
	 * Remove a rule.
	 * @param	rule Rule to remove.
	 * @return True is rule existed in the first place. False otherwise.
	 */
	public inline function remove(rule:String):Bool
	{
		return rules.remove(rule);
	}
	
	/**
	 * Iterate n amount of times over the current string, applying all currently set rules.
	 * @param	n Number of iterations to do - for convenience.
	 */
	public function iterate(n:UInt = 1):Void
	{
		for (i in 0...n)
		{
			var next:String = "";
			
			for (index in 0...current.length)
			{
				var char = current.charAt(index);
				
				if (rules.exists(char)) next += rules.get(char);
				else next += char;
			}
			
			current = next;
		}
	}
	
}