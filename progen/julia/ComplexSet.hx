package progen.julia;
import progen.geom.Vector2D;

/**
 * ...
 * @author P Svilans
 */
class ComplexSet
{
	
	public var position:Vector2D;
	public var zoom:Vector2D;
	
	public var width:UInt;
	public var height:UInt;
	
	public var data:Array<ComplexData>;
	
	public function new():Void
	{
		position = new Vector2D();
		zoom = new Vector2D(1.0, 1.0);
	}
	
	public function initialize(width:UInt, height:UInt):Void
	{
		this.width = width;
		this.height = height;
		
		data = createBuffer(width * height);
	}
	
	private inline function createBuffer(length:UInt):Array<ComplexData>
	{
		var buffer = new Array<ComplexData>();
		for (i in 0...length) buffer.push(new ComplexData());
		
		return buffer;
	}
	
	public function generate(iterations:UInt = 1):Void
	{
		for (x in 0...width)
		for (y in 0...height)
		{
			var current = data[y * width + x];
			
			if (current.valid)
			{
				for (i in 0...iterations)
				{
					process(current);
					
					current.iterations++;
					
					//if the point is outside the circle with radius 2: stop
					if ((current.real * current.real + current.imaginary * current.imaginary) > 4)
					{
						current.valid = false;
						break;
					}
				}
			}
		}
	}
	
	private function process(current:ComplexData):Void
	{
		
	}
	
}