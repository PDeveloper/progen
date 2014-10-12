package progen.julia;
import progen.geom.Vector2D;
import progen.julia.ComplexData;

/**
 * ...
 * @author P Svilans
 */
class JuliaSet extends ComplexSet
{
	
	public var constant_real:Float;
	public var constant_imaginary:Float;
	
	public function new(constant_real:Float = -0.7, constant_imaginary:Float = 0.27015):Void
	{
		this.constant_real = constant_real;
		this.constant_imaginary = constant_imaginary;
		
		super();
	}
	
	override public function initialize(width:UInt, height:UInt):Void
	{
		super.initialize(width, height);
		
		for (y in 0...height)
		for (x in 0...width)
		{
			var current = data[y * width + x];
			
			//calculate the initial real and imaginary part of z, based on the pixel location and zoom and position values
			current.real = 1.5 * (x - width / 2) / (0.5 * zoom.x * width) + position.x;
			current.imaginary = (y - height / 2) / (0.5 * zoom.y * height) + position.y;
		}
	}
	
	override function process(current:ComplexData):Void 
	{
		//remember value of previous iteration
		var old_real:Float = current.real;
		var old_imaginary:Float = current.imaginary;
		
		//the actual iteration, the real and imaginary part are calculated
		current.real = old_real * old_real - old_imaginary * old_imaginary + constant_real;
		current.imaginary = 2 * old_real * old_imaginary + constant_imaginary;
	}
	
}