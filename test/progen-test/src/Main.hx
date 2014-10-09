package ;

import drawing.Cursor;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import progen.dla.bounds.CircleBounds;
import progen.dla.bounds.PointBounds;
import progen.dla.DLA;
import progen.lsystem.LSystem;

/**
 * @author P Svilans
 */

class Main extends Sprite
{
	
	private var debug:Shape;
	private var cursor:Cursor;
	
	public function new():Void
	{
		super();
		
		if (stage != null) init();
		else addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event = null):Void
	{
		debug = new Shape();
		this.addChild(debug);
		
		test_dla();
		test_lsystem();
	}
	
	private function test_lsystem():Void
	{
		var g:Graphics = debug.graphics;
		cursor = new Cursor(g);
		
		g.lineStyle(1, 0xF0AD31);
		lsystem_koch();
		
		g.lineStyle(1, 0x60DB24);
		lsystem_plant();
	}
	
	private function lsystem_koch():Void
	{
		var system:LSystem = new LSystem("F");
		system.add("F", "F+F-F-F+F");
		
		system.iterate(3);
		
		cursor.setRotation(0.4);
		cursor.setXY(stage.stageWidth * 0.5, stage.stageHeight * 0.5);
		
		for (i in 0...system.current.length)
		{
			var char = system.current.charAt(i);
			
			if ( char == "F") cursor.drawForward(10);
			else if ( char == "-") cursor.rotate(-Math.PI * 0.5);
			else if ( char == "+") cursor.rotate(Math.PI * 0.5);
		}
	}
	
	private function lsystem_plant():Void
	{
		var system:LSystem = new LSystem("X");
		system.add("X", "F-[[X]+X]+F[+FX]-X");
		system.add("F", "FF");
		
		system.iterate(6);
		
		cursor.setRotation(-0.3);
		cursor.setXY(stage.stageWidth * 0.2, stage.stageHeight * 0.5);
		
		for (i in 0...system.current.length)
		{
			var char = system.current.charAt(i);
			
			if ( char == "F") cursor.drawForward(3);
			else if ( char == "-") cursor.rotate(-Math.PI * 0.12);
			else if ( char == "+") cursor.rotate(Math.PI * 0.12);
			else if ( char == "[") cursor.pushState();
			else if ( char == "]") cursor.popState();
		}
	}
	
	private function test_dla():Void
	{
		var dla = new DLA(new CircleBounds(280.0, 0.0, 40.0), new PointBounds());
		
		dla.construct(320, 1000);
		
		var g:Graphics = debug.graphics;
		g.lineStyle(1.0, 0x45E4E0);
		
		var cx = stage.stageWidth * 0.3;
		var cy = stage.stageHeight * 0.7;
		
		for (segment in dla.segments)
		{
			g.moveTo(segment.a.x + cx, segment.a.y + cy);
			g.lineTo(segment.b.x + cx, segment.b.y + cy);
		}
	}
	
	static function main():Void
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		// entry point
		
		stage.addChild(new Main());
	}
	
}