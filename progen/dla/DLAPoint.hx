package progen.dla;

/**
 * Simple Point class to hold x/y values and attached segments.
 * @author P Svilans
 */

class DLAPoint 
{
	
	public var isSet:Bool;
	
	public var x:Float;
	public var y:Float;
	
	public var segments:Array<DLASegment>;
	
	public function new(x:Float = 0.0, y:Float = 0.0) 
	{
		this.x = x;
		this.y = y;
		
		segments = new Array<DLASegment>();
		
		isSet = false;
	}
	
	/**
	 * Finds the distance between this and another point.
	 * @param	point
	 * @return The distance - surprise! :O
	 */
	public inline function distance(point:DLAPoint):Float
	{
		return Math.sqrt(distance_2( point));
	}
	
	/**
	 * Finds the distance squared between this and another point.
	 * @param	point
	 * @return
	 */
	public inline function distance_2(point:DLAPoint):Float
	{
		var dx:Float = point.x - this.x;
		var dy:Float = point.y - this.y;
		
		return dx * dx + dy * dy;
	}
	
	/**
	 * Clones this point.
	 * @return
	 */
	public inline function clone():DLAPoint
	{
		return new DLAPoint(x, y);
	}
	
	public function destroy():Void
	{
		for (segment in segments) segment.destroy();
	}
	
}