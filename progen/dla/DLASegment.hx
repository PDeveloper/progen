package progen.dla;

/**
 * A segment joining 2 points.
 * @author P Svilans
 */

class DLASegment 
{
	
	public var a:DLAPoint;
	public var b:DLAPoint;
	
	public function new(a:DLAPoint, b:DLAPoint) 
	{
		this.a = a;
		a.segments.push( this);
		
		this.b = b;
		b.segments.push( this);
	}
	
	public function destroy():Void
	{
		a.segments.remove( this);
		b.segments.remove( this);
		
		a = null;
		b = null;
	}
	
}