package agame.endless
{
	import com.agame.framework.Application;

	import agame.endless.work.StartupGameWork;

	public class EndlessApplication extends Application
	{
		protected var _startupGameWork:StartupGameWork;

		public function EndlessApplication()
		{
			super();
		}

		override protected function initliaze():void
		{
		}

		override public function startup():void
		{
			super.startup();

			_startupGameWork=new StartupGameWork(this);
			_startupGameWork.start();
		}
	}
}
