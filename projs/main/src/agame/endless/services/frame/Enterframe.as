package agame.endless.services.frame
{
	import flash.events.Event;
	
	import agame.endless.appStage;

	public class Enterframe
	{

		private var _iEnterframes:Vector.<IEnterframe>;

		private static var _current:Enterframe;
		public static function get current():Enterframe
		{
			if (_current == null)
				_current=new Enterframe;
			return _current;
		}

		public function Enterframe()
		{
			appStage.addEventListener(Event.ENTER_FRAME, onEachFrame);
			_iEnterframes=new Vector.<IEnterframe>;
		}

		public function add(target:IEnterframe):void
		{
			if (!has(target))
				_iEnterframes.push(target);
		}

		public function remove(target:IEnterframe):void
		{
			if (has(target))
			{
				var index:int=_iEnterframes.indexOf(target);
				_iEnterframes[index]=null;
			}
		}

		public function has(target:IEnterframe):Boolean
		{
			return _iEnterframes.indexOf(target) != -1;
		}

		private function onEachFrame(evt:Event):void
		{
			var len:int=_iEnterframes.length;
			if (len > 0)
			{
				for (var i:int=0; i < len; i++)
				{
					if (_iEnterframes[i])
						_iEnterframes[i].enterframe();
				}

				for (i=len - 1; i >= 0; i--)
				{
					if (_iEnterframes[i] == null)
						_iEnterframes.splice(i, 1);
				}
			}
		}
	}
}
