package agame.endless.modules.main.view.panel.section
{
	import agame.endless.services.assets.Assets;

	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;

	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extension.starlingide.display.movieclip.StarlingMovieClip;

	/**
	 * 一个段落的内容。
	 * 包含 标题、内容。
	 * @author hufan
	 */
	public class Section extends Sprite
	{
		private var sectionUI:StarlingMovieClip;
		private var contentLayOut:LayoutGroup;

		public function Section()
		{
			super();
			sectionUI=Assets.current.getLinkageInstance('endless.ui.SectionUI') as StarlingMovieClip;
			addChild(sectionUI);

			contentLayOut=new LayoutGroup;
			const vLayOut:VerticalLayout=new VerticalLayout;
			contentLayOut.layout=vLayOut;

			sectionUI.content.addChild(contentLayOut);
		}

		public function set title(value:String):void
		{
			sectionUI.title.text=value;
		}

		public function addContent(displayObject:DisplayObject):void
		{
			contentLayOut.addChild(displayObject);
		}

		public function validate():void
		{
			contentLayOut.validate();
		}
	}
}
