﻿package  me.rainssong.display
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import me.rainssong.events.SlideEvent;
	import me.rainssong.utils.superTrace;
	
	import flash.display.Sprite;
	import me.rainssong.display.MyMovieClip;
	import me.rainssong.display.Slide;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public dynamic class Slide extends MyMovieClip implements ISlide 
	{
		
		
		protected var _isLeftRollInEnabled:Boolean = true;
		protected var _isRightRollInEnabled:Boolean = true;
		protected var _isLeftRollOutEnabled:Boolean = true;
		protected var _isRightRollOutEnabled:Boolean = true;
		protected var _isLocked:Boolean = false;
		protected var _example:DisplayObject;
		
		public function Slide(value:*=null) 
		{
			super();
			
			if(value!=null)
				reload(value);
		}

		public function reload(value:*):void
		{
			unload();
			
			addChild(_example = DisplayObjectTransfer.transfer(value));
			_example.addEventListener(SlideEvent.LOCK, lock);
			_example.addEventListener(SlideEvent.UNLOCK, unlock);
			
		}

		public function unload():void
		{
			if (_example is Loader)
			Loader(_example).unloadAndStop();
			else if (_example is MovieClip)
			MovieClip(_example).stop();
			else if (_example is Bitmap)
			Bitmap(_example).bitmapData.dispose();
			
			if (_example && _example.parent)
			{
				removeChild(_example);
				_example = null;
			}
		}
		
		public function lock(e:SlideEvent=null):void
		{
			_isLocked = true;
		}
		
		public function unlock(e:SlideEvent=null):void
		{
			_isLocked = false;
		}
		
		override public function enable():void 
		{
			super.enable();
			
			if (_example is MovieClip)
				MovieClip(_example).play();
		}
		
		override public function disable():void 
		{
			super.disable();
			if (_example is MovieClip)
				MovieClip(_example).gotoAndStop(1);
		}
		
		override public function destroy():void 
		{
			unload();
			super.destroy();
		}
		
		public function get hasContent():Boolean
		{
			return _example?true: false;
		}
		
		public function get isLeftRollInEnabled():Boolean 
		{
			return _isLeftRollInEnabled;
		}
		
		public function get isRightRollInEnabled():Boolean 
		{
			return _isRightRollInEnabled;
		}
		
		public function get isLeftRollOutEnabled():Boolean 
		{
			return _isLeftRollOutEnabled;
		}
		
		public function get isRightRollOutEnabled():Boolean 
		{
			return _isRightRollOutEnabled;
		}
		
		public function get isLocked():Boolean 
		{
			return _isLocked;
		}
		
		
		
	}

}