package drawing ;

/**
 * @author P Svilans
 */

class CursorState 
{
	
	public var x:Float;
	public var y:Float;
	public var rotation:Float;
	
	public var colour:UInt;

	public function new(x:Float, y:Float, rotation:Float, colour:UInt = 0) 
	{
		this.x = x;
		this.y = y;
		this.rotation = rotation;
		
		this.colour = colour;
	}
	
}