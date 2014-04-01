package agame.endless.work
{
	import com.agame.services.work.SimpleWork;

	import agame.endless.EndlessApplication;

	public class EndlessWork extends SimpleWork
	{
		public var app:EndlessApplication;

		public function EndlessWork(app:EndlessApplication)
		{
			this.app = app;
			super();
		}
	}
}
