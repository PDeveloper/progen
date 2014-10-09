package progen.dla.bounds;
import progen.dla.DLAPoint;

/**
 * ...
 * @author P Svilans
 */

class CircleBounds extends DLAPoint implements IBounds
{
	
	public var gravity:Float;
	public var radius:Float;
	
	public function new(radius:Float, x:Float = 0.0, y:Float = 0.0, gravity:Float = 1.0) 
	{
		super(x, y);
		
		this.gravity = gravity;
		this.radius = radius;
	}
	
	/* INTERFACE progen.dla.bounds.IBounds */
	
	public function center():DLAPoint
	{
		return this;
	}
	
	public function create(t:Float):DLAPoint 
	{
		var rads:Float = t * Math.PI * 2;
		
		return new DLAPoint(Math.cos(rads) * radius + x, Math.sin(rads) * radius + y);
	}
	
	public function getClosestVector(point:DLAPoint):DLAPoint
	{
		var dx = x - point.x;
		var dy = y - point.y;
		var d = Math.sqrt(dx * dx + dy * dy);
		dx = dx / d;
		dy = dy / d;
		
		if (isWithinBounds(point)) return new DLAPoint(-dx * gravity, -dy * gravity);
		else return new DLAPoint(dx * gravity, dy * gravity);
	}
	
	public function distanceToBound(point:DLAPoint):Float 
	{
		var d = distance(point);
		
		return radius - d;
	}
	
	public function isWithinBounds(point:DLAPoint):Bool 
	{
		var d = distance_2(point);
		if (d < radius * radius) return true;
		return false;
	}
	
}