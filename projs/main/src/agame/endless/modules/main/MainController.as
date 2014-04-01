package agame.endless.modules.main
{
	import com.agame.framework.module.Module;

	import starling.events.EventDispatcher;

	public class MainController extends EventDispatcher
	{
		protected var _module:Module;

		public function MainController(module:Module)
		{
			this._module=module;
			super();
		}

		protected function initliaze():void
		{
			initModel();
			initView();
		}

		protected function initView():void
		{
		}

		protected function disposeView():void
		{
		}

		protected function initModel():void
		{
		}

		protected function disposeModel():void
		{
		}
	}
}
