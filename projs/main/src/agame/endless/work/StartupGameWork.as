package agame.endless.work
{
	import com.agame.services.work.Workflow;

	import agame.endless.EndlessApplication;

	/**
	 * 启动游戏流程
	 * @author hufan
	 */
	public class StartupGameWork extends EndlessWork
	{
		private var _flow:Workflow;

		public function StartupGameWork(app:EndlessApplication)
		{
			super(app);
		}

		override public function start():void
		{
//			_flow.registeWork(
		}
	}
}
