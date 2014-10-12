package progen.julia;
import progen.geom.Vector2D;
import progen.julia.ComplexData;

/**
 * ...
 * @author P Svilans
 */

class MandelbrotSet extends ComplexSet
{
	
	public function new():Void
	{
		super();
	}
	
	override function process(current:ComplexData):Void 
	{
		//calculate the initial real and imaginary part of z, based on the pixel location and zoom and position values
		var pr = 1.5 * (x - width / 2) / (0.5 * zoom.x * width) + position.x;
		var pi = (y - height / 2) / (0.5 * zoom.y * width) + position.y;
		
		//remember value of previous iteration
		var old_real:Float = current.real;
		var old_imaginary:Float = current.imaginary;
		
		//the actual iteration, the real and imaginary part are calculated
		current.real = old_real * old_real - old_imaginary * old_imaginary + pr;
		current.imaginary = 2 * old_real * old_imaginary + pi;
	}
	
}