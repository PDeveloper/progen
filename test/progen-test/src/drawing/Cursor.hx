package drawing ;
import flash.display.Graphics;

/**
 * @author P Svilans
 */

class Cursor
{
	
	private var cx:Float;
	private var cy:Float;
	private var cr:Float;
	
	private var states:Array<CursorState>;
	
	private var graphics:Graphics;

	public function new(graphics:Graphics) 
	{
		cx = cy = cr = 0.0;
		states = new Array<CursorState>();
		
		this.graphics = graphics;
	}
	
	public function setState(state:CursorState):Void 
	{
		cx = state.x;
		cy = state.y;
		cr = state.rotation;
	}
	
	public function setXY(x:Float, y:Float):Void 
	{
		cx = x;
		cy = y;
	}
	
	public function setRotation(radians:Float):Void 
	{
		cr = radians;
	}
	
	public function drawForward(distance:Float):Void 
	{
		graphics.moveTo(cx, cy);
		
		var dx:Float = Math.cos(cr);
		var dy:Float = Math.sin(cr);
		
		cx += dx * distance;
		cy += dy * distance;
		
		graphics.lineTo(cx, cy);
	}
	
	public function rotate(radians:Float):Void 
	{
		cr += radians;
	}
	
	public function pushState():Void 
	{
		states.push(new CursorState(cx, cy, cr));
	}
	
	public function popState():Void 
	{
		if (states.length > 0) setState(states.pop());
	}
	
}