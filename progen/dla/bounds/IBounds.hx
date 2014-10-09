package progen.dla.bounds;
import progen.dla.DLAPoint;

/**
 * ...
 * @author P Svilans
 */

interface IBounds 
{
	
	public var gravity:Float;
	
	/**
	 * Gets the center coordinates of the bound.
	 * @return Center point.
	 */
	public function center():DLAPoint;
	
	/**
	 * Creates a point on the perimeter of this bound.
	 * @param	t 0.0 - 1.0 - distance along the bound on which to generate the point.
	 * @return The point created.
	 */
	public function create(t:Float):DLAPoint;
	
	public function getClosestVector(point:DLAPoint):DLAPoint;
	public function distanceToBound(point:DLAPoint):Float;
	public function isWithinBounds(point:DLAPoint):Bool;
	
}