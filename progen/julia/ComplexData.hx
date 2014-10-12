package progen.julia;

/**
 * ...
 * @author P Svilans
 */

class ComplexData
{
	
	public var real:Float;
	public var imaginary:Float;
	
	public var valid:Bool;
	public var iterations:Int;
	
	public function new(real:Float = 0.0, imaginary:Float = 0.0):Void
	{
		this.real = real;
		this.imaginary = imaginary;
		
		valid = true;
		iterations = 0;
	}
	
}