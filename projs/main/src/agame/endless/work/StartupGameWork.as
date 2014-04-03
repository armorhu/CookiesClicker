package agame.endless.work
{
	import com.agame.services.work.WorkFlowEvent;
	import com.agame.services.work.Workflow;

	import agame.endless.EndlessApplication;
	import agame.endless.services.assets.Assets;
	import agame.endless.work.init.LaunchModuleWork;
	import agame.endless.work.init.StartupStarlingWork;

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
			_flow=new Workflow();
			_flow.registeWork(new StartupStarlingWork(app), false, '启动Starling');
//			_flow.registeWork(AppConfig, false, '初始化配置');
			_flow.registeWork(Assets.current, false, '初始化资源');
			_flow.registeWork(new LaunchModuleWork(app), false, '启动模块');
			_flow.addEventListeners(startupWorkflowEvent);
			_flow.start();
		}

		private function startupWorkflowEvent(evt:WorkFlowEvent):void
		{
			if (evt.type == WorkFlowEvent.QUEUE_COMPLETE)
				flowQueueCompleteHandler();
		}

		private function flowQueueCompleteHandler():void
		{
			trace('启动成功');
			workComplete();
		}
	}
}
