package agame.endless.modules.main.view.panel.stats
{
	import com.agame.utils.Beautify;

	import flash.utils.setTimeout;

	import agame.endless.configs.lang.Lang;
	import agame.endless.configs.lang.LangPattern;
	import agame.endless.configs.texts.TextsTIDDefs;
	import agame.endless.modules.main.model.Game;
	import agame.endless.modules.main.view.achievements.AchievementItemRender;
	import agame.endless.modules.main.view.panel.section.Section;
	import agame.endless.modules.main.view.panel.section.Sentence;
	import agame.endless.modules.main.view.upgrades.UpgradeItemRender;

	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;

	import starling.core.RenderSupport;

	public class StatsPanel extends LayoutGroup
	{
		private var lasSection:Section;
		private var sentenceMap:Object={};
		private var panelWidth:Number;

		public function StatsPanel(width:Number)
		{
			super();
			panelWidth=width;
		}

		public static const general:String='general';
		public static const upgrades_unlock:String='upgrades_unlock';
		public static const achievements:String='achievements';

		public static const cookie_in_bank:String='cookies_in_bank';
		public static const cookies_baked:String='cookies_baked';
		public static const cookies_baked_all_time:String='cookies_baked_all_time';
		public static const session_start:String='session_start';
		public static const building_owned:String='building_owned';
		public static const cookies_per_secend:String='cookies_per_secend';
		public static const cookies_per_click:String='cookies_per_click';
		public static const cookies_click:String='cookies_click';
		public static const hand_maked_cookies:String='hand_maked_cookies';
		public static const gloden_cookies:String='golden_cookies';
		public static const running_version:String='running_version';


		override protected function initialize():void
		{
			const vLayout:VerticalLayout=new VerticalLayout;
			vLayout.gap=10;
			vLayout.hasVariableItemDimensions=true;
			this.layout=vLayout;
			//综合
			addSection(general, Lang(TextsTIDDefs.TID_SECTION_GENERAL));
			addSentence(cookie_in_bank, Lang(TextsTIDDefs.TID_COOKIES_IN_BANK));
			addSentence(cookies_baked, Lang(TextsTIDDefs.TID_COOKIES_BAKED));
			addSentence(cookies_baked_all_time, Lang(TextsTIDDefs.TID_COOKIES_BAKED_ALL_TIME));
			addSentence(session_start, Lang(TextsTIDDefs.TID_SESSION_START));
			addSentence(building_owned, Lang(TextsTIDDefs.TID_BUILDING_OWNED));
			addSentence(cookies_per_secend, Lang(TextsTIDDefs.TID_COOKIES_PER_SECEND));
			addSentence(cookies_per_click, Lang(TextsTIDDefs.TID_COOKIES_PER_CLICK));
			addSentence(cookies_click, Lang(TextsTIDDefs.TID_COOKIES_CLICKED));
			addSentence(hand_maked_cookies, Lang(TextsTIDDefs.TID_HAND_MAKE_COOKIE));
			addSentence(gloden_cookies, Lang(TextsTIDDefs.TID_GOLDEN_CLICK));
			addSentence(running_version, Lang(TextsTIDDefs.TID_RUNNING_VERSION));
			completeSection(false);


			//unlock upgrade list
			const upgradeLayout:TiledRowsLayout=new TiledRowsLayout;
			upgradeLayout.gap=4;
			addSection(upgrades_unlock, Lang(TextsTIDDefs.TID_SECTION_UNLOCK_UPGRADES));
			_unlockUpgradeGroup=new List
			_unlockUpgradeGroup.width=panelWidth;
			_unlockUpgradeGroup.layout=upgradeLayout;
			_unlockUpgradeGroup.itemRendererType=UpgradeItemRender;
			lasSection.addContent(_unlockUpgradeGroup);
			completeSection(true);


			//成就列表
			const achievement:TiledRowsLayout=new TiledRowsLayout;
			achievement.gap=4;
			addSection(achievements, Lang(TextsTIDDefs.TID_ACHIEVEMENTS));
			_achievement=new List
			_achievement.width=panelWidth;
			_achievement.dataProvider=new ListCollection;
			_achievement.layout=achievement;
			_achievement.itemRendererType=AchievementItemRender;
			lasSection.addContent(_achievement);
			var len:int=Game.AchievementsById.length
			for (var i:int=0; i < len; i++)
				_achievement.dataProvider.addItem(Game.AchievementsById[i]);
			completeSection(true);

			renderGenernalSection();
		}

		public function addSection(name:String, title:String):Section
		{
			var section:Section=new Section();
			section.title=title;
			section.name=name;
			lasSection=section;
			return section;
		}

		public function completeSection(flat:Boolean):void
		{
			addChild(lasSection);
			lasSection.validate();
			if (flat)
				setTimeout(lasSection.flatten, 1);
			lasSection=null;
		}

		public function addSentence(name:String, head:String):Sentence
		{
			var sentence:Sentence=new Sentence(panelWidth, 40, 30, 0x999999, 0xffffff);
			sentence.head=head;
			sentence.name=name;
			lasSection.addContent(sentence);
			sentenceMap[sentence.name]=sentence;
			return sentence;
		}

		public function setSentenceContext(name:String, context:String):void
		{
			var sentence:Sentence=sentenceMap[name];
			sentence.context=context;
		}

		override public function render(support:RenderSupport, parentAlpha:Number):void
		{
			// TODO Auto Generated method stub
			if (stage)
			{
				if (Game.T % (Game.fps * 2) == 0)
					renderGenernalSection();
			}
			super.render(support, parentAlpha);
		}

		private function renderGenernalSection():void
		{
			setSentenceContext(cookie_in_bank, Beautify(Game.cookies));
			setSentenceContext(cookies_baked, Beautify(Game.cookiesEarned));
			setSentenceContext(cookies_baked_all_time, Beautify(Game.cookiesReset + Game.cookiesEarned));
			setSentenceContext(session_start, Lang(TextsTIDDefs.TID_SESSION_START));
			setSentenceContext(building_owned, Beautify(Game.BuildingsOwned));
			setSentenceContext(cookies_per_secend, Beautify(Game.cookiesPs, 1) + '(' + // 
				Lang(TextsTIDDefs.TID_MULTIPLIER).replace(LangPattern.Number, Beautify(Math.round(Game.globalCpsMult * 100), 1))) + '%)';
			setSentenceContext(cookies_per_click, Beautify(Game.computedMouseCps, 1));
			setSentenceContext(cookies_click, Beautify(Game.cookieClicks));
			setSentenceContext(hand_maked_cookies, Beautify(Game.handmadeCookies));
			setSentenceContext(gloden_cookies, Beautify(Game.goldenClicksLocal));
		}

		public function sec(name:String):Section
		{
			return getChildByName(name) as Section;
		}

		////==========================================================================////
		////==========================  unlock upgrade    ============================////
		////==========================================================================////
		private var _unlockUpgradeGroup:List;

		public function addUnlock():void
		{
		}


		////==========================================================================////
		////==========================  achievement       ============================////
		////==========================================================================////
		private var _achievement:List;

		public function winAchievement():void
		{
		}

	}
}
