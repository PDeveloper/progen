package progen.dla.bounds;
import progen.dla.DLAPoint;

/**
 * ...
 * @author P Svilans
 */

class PointBounds extends DLAPoint implements IBounds
{
	
	public var gravity:Float;

	public function new(x:Float = 0.0, y:Float = 0.0, gravity:Float = 1.0) 
	{
		super(x, y);
		
		this.gravity = gravity;
	}
	
	/* INTERFACE progen.dla.bounds.IBounds */
	
	public function center():DLAPoint
	{
		return this;
	}
	
	public function create(t:Float):DLAPoint 
	{
		return new DLAPoint(x, y);
	}
	
	public function getClosestVector(point:DLAPoint):DLAPoint
	{
		var dx = x - point.x;
		var dy = y - point.y;
		var d = Math.sqrt( dx * dx + dy * dy);
		dx = dx / d;
		dy = dy / d;
		
		return new DLAPoint(dx * gravity, dy * gravity);
	}
	
	public function distanceToBound(point:DLAPoint):Float 
	{
		return distance(point);
	}
	
	public function isWithinBounds(point:DLAPoint):Bool
	{
		return false;
	}
	
}