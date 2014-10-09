package progen.dla;
import progen.dla.bounds.IBounds;

/**
 * DLA for generating weird structures of segments and points.
 * @author P Svilans
 */

class DLA 
{
	
	/**
	 * The number of active points in the simulation.
	 */
	public var points:Array<DLAPoint>;
	
	/**
	 * Generated segments from the simulation.
	 */
	public var segments:Array<DLASegment>;
	
	public var origin:IBounds;
	public var target:IBounds;
	
	public var gravity:Float = 1.0;
	public var threshold:Float;
	public var motion:DLAPoint;
	
	/**
	 * Creates a DLA with the given origin and target bounds. Points will be spawned along the origin bound,
	 * and will freeze once they come in range of the target bound. All generated segments are guaranteed to
	 * be interconnected with one another (no islands).
	 * @param	origin Origin bound on which to spawn points.
	 * @param	target Bound that freezes points on contact.
	 */
	public function new(origin:IBounds, target:IBounds, gravity:Float = 1.0, threshold:Float = 10.0, motion:DLAPoint = null) 
	{
		this.origin = origin;
		this.target = target;
		
		this.gravity = gravity;
		this.threshold = threshold;
		this.motion = (motion != null) ? motion : new DLAPoint(10.0, 10.0);
	}
	
	/**
	 * Simulate a certain number of points to construct the DLA.
	 * @param	amount The amount of points to simulate.
	 * @param	iterations How many iterations before terminating.
	 * @return If all points have been frozen, returns true. If some point haven't stuck to the DLA yet, returns false.
	 */
	public function construct(amount:Int = 500, iterations:Int = 1000):Bool
	{
		var joined:Array<DLAPoint> = new Array<DLAPoint>();
		points = [];
		segments = [];
		
		for (i in 0...amount) points.push(origin.create(Math.random()));
		
		for (i in 0...iterations)
		{
			for (point in points)
			{
				var d = target.distanceToBound(point);
				var o = target.getClosestVector(point);
				
				point.x += o.x * gravity + Math.random() * motion.x - motion.x * 0.5;
				point.y += o.y * gravity + Math.random() * motion.y - motion.y * 0.5;
				
				var minimumDistance:Float = Math.min(d * d + 1, threshold * threshold);
				var minimumPoint:DLAPoint = null;
				
				for (set in joined)
				{
					var d = set.distance_2(point);
					
					if (d < minimumDistance)
					{
						minimumDistance = d;
						minimumPoint = set;
					}
				}
				
				if (minimumDistance < threshold * threshold && (minimumPoint != null || joined.length == 0))
				{
					point.isSet = true;
					
					points.remove(point);
					joined.push(point);
				}
				
				if (minimumPoint != null) segments.push(new DLASegment(point, minimumPoint));
			}
			
			if (points.length == 0) return true;
		}
		
		return false;
	}
	
}