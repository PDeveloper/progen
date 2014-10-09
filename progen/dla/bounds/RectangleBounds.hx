package progen.dla.bounds;
import progen.dla.DLAPoint;

/**
 * ...
 * @author P Svilans
 */

class RectangleBounds extends DLAPoint implements IBounds
{
	
	public var width:Float;
	public var height:Float;
	
	public var gravity:Float;
	
	private var point:DLAPoint;
	
	public function new(width:Float, height:Float, x:Float = 0.0, y:Float = 0.0, gravity:Float = 1.0) 
	{
		super(x, y);
		this.width = width;
		this.height = height;
		
		this.gravity = gravity;
		
		point = new DLAPoint(x + width * 0.5, y + height * 0.5);
	}
	
	/* INTERFACE progen.dla.bounds.IBounds */
	
	public function center():DLAPoint
	{
		point.x = x + width * 0.5;
		point.y = y + height * 0.5;
		
		return point;
	}
	
	public function create(t:Float):DLAPoint 
	{
		t = ((t - Math.floor( t)) * 4);
		
		var s = Math.floor(t);
		var ts = t - s;
		
		if (s == 0) return new DLAPoint(x + ts * width, y);
		else if (s == 1) return new DLAPoint(x + width, y + ts * height);
		else if (s == 2) return new DLAPoint(x + width - ts * width, y + height);
		else if (s == 3) return new DLAPoint(x, y + height - ts * height);
		
		// Shouldn't get here...ever...
		return null;
	}
	
	public function getClosestVector(point:DLAPoint):DLAPoint
	{
		var dx1:Float = point.x - x;
		var dx2:Float = x + width - point.x;
		var dy1:Float = point.y - y;
		var dy2:Float = y + height - point.y;
		
		var d:Float = 0.0;
		var mx:Float = 0.0;
		var my:Float = 0.0;
		
		if (dx1 > 0 && dx2 > 0 && dy1 > 0 && dy2 > 0)
		{
			if (dx1 < dx2) mx = -dx1;
			else mx = dx2;
			if (dy1 < dy2) my = -dy1;
			else my = dy2;
			
			if (Math.abs(mx) < Math.abs(my))
			{
				d = Math.abs(mx);
				mx = mx / d;
				my = 0;
			}
			else
			{
				d = Math.abs(my);
				mx = 0;
				my = my / d;
			}
			
			return new DLAPoint(mx * gravity, my * gravity);
		}
		else if (dx1 > 0 && dx2 > 0)
		{
			my = Math.min(dy1, dy2);
			
			return new DLAPoint(0.0, (my / -my) * gravity);
		}
		else if (dy1 > 0 && dy2 > 0)
		{
			mx = Math.min(dx1, dx2);
			
			return new DLAPoint((mx / -mx) * gravity, 0.0);
		}
		else
		{
			mx = Math.min(dx1, dx2);
			my = Math.min(dy1, dy2);
			d = Math.sqrt(mx * mx + my * my);
			mx = mx / d;
			my = my / d;
			
			return new DLAPoint(mx * gravity, my * gravity);
		}
	}
	
	public function distanceToBound(point:DLAPoint):Float 
	{
		var dx:Float;
		var dy:Float;
		
		if (isWithinBounds(point))
		{
			dx = Math.min(Math.abs(point.x - x), Math.abs(point.x - x + width));
			dy = Math.min(Math.abs(point.y - y), Math.abs(point.y - y + height));
			return Math.min(dx, dy);
		}
		else if (point.x > x && point.x < x + width)
		{
			if (point.y <= y) dy = point.y - y;
			else dy = y + height - point.y;
			
			return dy;
		}
		else if (point.y > y && point.y < y + height)
		{
			if (point.x <= x) dx = point.x - x;
			else dx = x + width - point.x;
			
			return dx;
		}
		else
		{
			if (point.x <= x) dx = x - point.x;
			else dx = point.x - x + width;
			if (point.y <= y) dy = y - point.y;
			else dy = point.y - y + height;
			
			return -Math.sqrt(dx * dx + dy * dy);
		}
	}
	
	inline public function isWithinBounds(point:DLAPoint):Bool
	{
		if (point.x > x && point.y > y && point.x < x + width && point.y < y + height) return true;
		return false;
	}
	
}