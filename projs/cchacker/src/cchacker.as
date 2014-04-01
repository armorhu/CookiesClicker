package
{
	import com.agame.services.load.ResourceManager;
	import com.agame.services.load.resource.Resource;
	import com.agame.services.load.resource.ResourceType;
	import com.amgame.utils.FileUtil;

	import flash.display.Sprite;
	import flash.utils.ByteArray;

	/**
	 * 抓取cookies clicker的专用项目
	 * @author hufan
	 */
	public class cchacker extends Sprite
	{
		public function cchacker()
		{
			downloadFile("alarmTurret.png"); //	29-Dec-2013 00:56	440	 
			downloadFile("alchemylab.png"); //	29-Dec-2013 00:56	820	 
			downloadFile("alchemylabBackground.png"); //	29-Dec-2013 00:56	472	 
			downloadFile("alchemylabIcon.png"); //	29-Dec-2013 00:56	854	 
			downloadFile("alchemylabIconOff.png"); //	13-Feb-2014 14:25	313	 
			downloadFile("alteredGrandma.png"); //	29-Dec-2013 00:56	470	 
			downloadFile("angrySentientCookie.png"); //	29-Dec-2013 00:56	498	 
			downloadFile("antiGrandma.png"); //	29-Dec-2013 00:56	526	 
			downloadFile("antimattercondenser.png"); //	29-Dec-2013 00:56	666	 
			downloadFile("antimattercondenserBackground.png"); //	29-Dec-2013 00:56	966	 
			downloadFile("antimattercondenserIcon.png"); //	29-Dec-2013 00:56	905	 
			downloadFile("antimattercondenserIconOff.png"); //	13-Feb-2014 14:27	207	 
			downloadFile("aqworldsbanner.jpg"); //	29-Dec-2013 17:33	 29K	 
			downloadFile("ascendedBakingPod.png"); //	29-Dec-2013 00:56	1.7K	 
			downloadFile("babySentientCookie.png"); //	29-Dec-2013 00:56	303	 
			downloadFile("bgBlue.jpg"); //	29-Dec-2013 17:33	 54K	 
			downloadFile("bgMoney.jpg"); //	01-Apr-2014 00:00	 69K	 
			downloadFile("bgMoneyChart.jpg"); //	01-Apr-2014 00:40	9.7K	 
			downloadFile("blackGradient.png"); //	29-Dec-2013 00:56	561	 
			downloadFile("burntSentientCookie.png"); //	29-Dec-2013 00:56	523	 
			downloadFile("buttonTile.jpg"); //	29-Dec-2013 17:33	7.6K	 
			downloadFile("caramelWave.png"); //	29-Dec-2013 00:56	 11K	 
			downloadFile("chirpy.png"); //	29-Dec-2013 00:56	426	 
			downloadFile("chocolateMilkWave.png"); //	29-Dec-2013 00:57	 10K	 
			downloadFile("contract.png"); //	31-Mar-2014 22:50	4.8K	 
			downloadFile("control.png"); //	29-Dec-2013 00:57	 48K	 
			downloadFile("cookieShower1.png"); //	29-Dec-2013 00:57	 29K	 
			downloadFile("cookieShower2.png"); //	29-Dec-2013 00:57	 55K	 
			downloadFile("cookieShower3.png"); //	29-Dec-2013 00:58	 76K	 
			downloadFile("cosmicGrandma.png"); //	29-Dec-2013 00:58	616	 
			downloadFile("crazedDoughSpurter.png"); //	29-Dec-2013 00:58	597	 
			downloadFile("crazedKneader.png"); //	29-Dec-2013 00:58	820	 
			downloadFile("cursor.png"); //	29-Dec-2013 00:58	335	 
			downloadFile("cursoricon.png"); //	29-Dec-2013 00:58	378	 
			downloadFile("cursoriconOff.png"); //	13-Feb-2014 14:26	297	 
			downloadFile("darkNoise.png"); //	29-Dec-2013 00:58	1.7K	 
			downloadFile("disgruntledCleaningLady.png"); //	29-Dec-2013 00:58	893	 
			downloadFile("disgruntledOverseer.png"); //	29-Dec-2013 00:58	902	 
			downloadFile("disgruntledWorker.png"); //	29-Dec-2013 00:58	865	 
			downloadFile("doughling.png"); //	29-Dec-2013 00:58	418	 
			downloadFile("dungeonFactory.png"); //	29-Dec-2013 00:58	2.3K	 
			downloadFile("dungeonIcons.png"); //	29-Dec-2013 00:58	4.3K	 
			downloadFile("dungeonOverlay.png"); //	29-Dec-2013 00:58	 13K	 
			downloadFile("dungeonTiles.png"); //	29-Dec-2013 00:58	3.4K	 
			downloadFile("elderDoughling.png"); //	29-Dec-2013 00:58	744	 
			downloadFile("elfGrandma.png"); //	29-Dec-2013 00:58	622	 
			downloadFile("empty.png"); //	29-Dec-2013 00:58	 95	 
			downloadFile("factory.png"); //	29-Dec-2013 00:58	477	 
			downloadFile("factoryBackground.png"); //	29-Dec-2013 00:58	1.3K	 
			downloadFile("factoryIcon.png"); //	29-Dec-2013 00:58	667	 
			downloadFile("factoryIconOff.png"); //	13-Feb-2014 14:24	192	 
			downloadFile("farm.png"); //	29-Dec-2013 00:58	765	 
			downloadFile("farmBackground.png"); //	29-Dec-2013 00:58	812	 
			downloadFile("farmIcon.png"); //	29-Dec-2013 00:58	904	 
			downloadFile("farmIconOff.png"); //	13-Feb-2014 14:23	288	 
			downloadFile("farmerGrandma.png"); //	29-Dec-2013 00:58	615	 
			downloadFile("foolAlchemyLab.png"); //	01-Apr-2014 00:28	351	 
			downloadFile("foolCondenser.png"); //	01-Apr-2014 00:27	364	 
			downloadFile("foolCursor.png"); //	01-Apr-2014 00:24	384	 
			downloadFile("foolFactory.png"); //	01-Apr-2014 00:24	273	 
			downloadFile("foolFarm.png"); //	01-Apr-2014 00:24	333	 
			downloadFile("foolGrandma.png"); //	01-Apr-2014 00:24	248	 
			downloadFile("foolMine.png"); //	01-Apr-2014 00:25	297	 
			downloadFile("foolPortal.png"); //	01-Apr-2014 00:29	303	 
			downloadFile("foolPrism.png"); //	01-Apr-2014 00:27	391	 
			downloadFile("foolShipment.png"); //	01-Apr-2014 00:25	340	 
			downloadFile("foolTimeMachine.png"); //	01-Apr-2014 00:27	440	 
			downloadFile("frostedReindeer.png"); //	29-Dec-2013 00:58	9.7K	 
			downloadFile("girlscoutChip.png"); //	29-Dec-2013 00:58	751	 
			downloadFile("girlscoutCrumb.png"); //	29-Dec-2013 00:58	738	 
			downloadFile("girlscoutDoe.png"); //	29-Dec-2013 00:58	762	 
			downloadFile("girlscoutLucky.png"); //	29-Dec-2013 00:58	754	 
			downloadFile("goldCookie.png"); //	29-Dec-2013 00:58	4.0K	 
			downloadFile("grandma.png"); //	29-Dec-2013 00:58	571	 
			downloadFile("grandmaBackground.png"); //	29-Dec-2013 00:58	837	 
			downloadFile("grandmaIcon.png"); //	29-Dec-2013 00:58	1.2K	 
			downloadFile("grandmaIconB.png"); //	29-Dec-2013 00:58	1.3K	 
			downloadFile("grandmaIconC.png"); //	29-Dec-2013 00:58	1.3K	 
			downloadFile("grandmaIconD.png"); //	29-Dec-2013 00:58	1.1K	 
			downloadFile("grandmaIconOff.png"); //	13-Feb-2014 14:23	249	 
			downloadFile("grandmas1.jpg"); //	29-Dec-2013 17:33	 21K	 
			downloadFile("grandmas2.jpg"); //	29-Dec-2013 17:33	 17K	 
			downloadFile("grandmas3.jpg"); //	29-Dec-2013 17:33	 26K	 
			downloadFile("grandmasGrandma.png"); //	29-Dec-2013 00:58	619	 
			downloadFile("heartStorm.png"); //	10-Feb-2014 03:59	 64K	 
			downloadFile("hearts.png"); //	10-Feb-2014 03:54	 23K	 
			downloadFile("hpBar.png"); //	29-Dec-2013 00:58	781	 
			downloadFile("hpmBar.png"); //	29-Dec-2013 00:58	778	 
			downloadFile("icons.png"); //	31-Mar-2014 23:06	 36K	 
			downloadFile("imperfectCookie.png"); //	29-Dec-2013 00:59	 94K	 
			downloadFile("infoBG.png"); //	29-Dec-2013 00:59	 94	 
			downloadFile("infoBGfade.png"); //	29-Dec-2013 00:59	276	 
			downloadFile("mapBG.jpg"); //	29-Dec-2013 17:33	 13K	 
			downloadFile("mapIcons.png"); //	29-Dec-2013 00:59	664	 
			downloadFile("mapTiles.png"); //	29-Dec-2013 00:59	595	 
			downloadFile("marshmallows.png"); //	29-Dec-2013 00:59	2.6K	 
			downloadFile("milk.png"); //	29-Dec-2013 01:00	6.3K	 
			downloadFile("milkWave.png"); //	29-Dec-2013 01:00	 16K	 
			downloadFile("mine.png"); //	29-Dec-2013 01:00	668	 
			downloadFile("mineBackground.png"); //	29-Dec-2013 01:00	1.0K	 
			downloadFile("mineIcon.png"); //	29-Dec-2013 01:00	725	 
			downloadFile("mineIconOff.png"); //	13-Feb-2014 14:24	227	 
			downloadFile("minerGrandma.png"); //	29-Dec-2013 01:00	626	 
			downloadFile("money.png"); //	29-Dec-2013 01:00	280	 
			downloadFile("mysteriousHero.png"); //	29-Dec-2013 01:00	366	 
			downloadFile("mysteriousOpponent.png"); //	29-Dec-2013 01:00	561	 
			downloadFile("orangeWave.png"); //	29-Dec-2013 01:01	 11K	 
			downloadFile("panelHorizontal.png"); //	29-Dec-2013 01:01	7.0K	 
			downloadFile("panelVertical.png"); //	29-Dec-2013 01:01	7.6K	 
			downloadFile("perfectCookie.png"); //	29-Dec-2013 01:01	 96K	 
			downloadFile("portal.png"); //	29-Dec-2013 01:01	1.0K	 
			downloadFile("portalBackground.png"); //	29-Dec-2013 01:01	3.6K	 
			downloadFile("portalIcon.png"); //	29-Dec-2013 01:01	1.1K	 
			downloadFile("portalIconOff.png"); //	13-Feb-2014 14:25	233	 
			downloadFile("portraitChip.png"); //	29-Dec-2013 01:01	940	 
			downloadFile("portraitCrumb.png"); //	29-Dec-2013 01:01	967	 
			downloadFile("portraitDoe.png"); //	29-Dec-2013 01:01	1.0K	 
			downloadFile("portraitLucky.png"); //	29-Dec-2013 01:01	1.0K	 
			downloadFile("prism.png"); //	13-Feb-2014 13:48	782	 
			downloadFile("prismBackground.png"); //	13-Feb-2014 11:31	701	 
			downloadFile("prismIcon.png"); //	13-Feb-2014 11:46	674	 
			downloadFile("prismIconOff.png"); //	13-Feb-2014 14:28	333	 
			downloadFile("rainbowGrandma.png"); //	13-Feb-2014 12:07	626	 
			downloadFile("raspberryWave.png"); //	29-Dec-2013 01:02	 10K	 
			downloadFile("rawSentientCookie.png"); //	29-Dec-2013 01:02	530	 
			downloadFile("santa.png"); //	29-Dec-2013 01:02	9.3K	 
			downloadFile("sentientFurnace.png"); //	29-Dec-2013 01:02	1.6K	 
			downloadFile("shadedBorders.png"); //	29-Dec-2013 01:02	2.3K	 
			downloadFile("shadedBordersGold.png"); //	29-Dec-2013 01:02	2.3K	 
			downloadFile("shadedBordersRed.png"); //	29-Dec-2013 01:02	2.3K	 
			downloadFile("shine.png"); //	29-Dec-2013 01:02	6.0K	 
			downloadFile("shipment.png"); //	29-Dec-2013 01:02	507	 
			downloadFile("shipmentBackground.png"); //	29-Dec-2013 01:02	923	 
			downloadFile("shipmentIcon.png"); //	29-Dec-2013 01:02	805	 
			downloadFile("shipmentIconOff.png"); //	13-Feb-2014 14:24	298	 
			downloadFile("smallCookies.png"); //	29-Dec-2013 01:02	 14K	 
			downloadFile("snow.jpg"); //	29-Dec-2013 17:33	 47K	 
			downloadFile("snow2.jpg"); //	29-Dec-2013 17:33	 71K	 
			downloadFile("spookyCookie.png"); //	29-Dec-2013 01:02	4.3K	 
			downloadFile("storeTile.jpg"); //	29-Dec-2013 17:33	 18K	 
			downloadFile("sugarBunny.png"); //	29-Dec-2013 01:02	239	 
			downloadFile("timemachine.png"); //	29-Dec-2013 01:02	773	 
			downloadFile("timemachineBackground.png"); //	29-Dec-2013 01:02	1.2K	 
			downloadFile("timemachineIcon.png"); //	29-Dec-2013 01:02	564	 
			downloadFile("timemachineIconOff.png"); //	13-Feb-2014 14:27	293	 
			downloadFile("timerBars.png"); //	10-Feb-2014 06:26	2.3K	 
			downloadFile("transmutedGrandma.png"); //	29-Dec-2013 01:02	449	 
			downloadFile("upgradeFrame.png"); //	29-Dec-2013 01:02	880	 
			downloadFile("winterFrame.png"); //	29-Dec-2013 01:02	898	 
			downloadFile("winterWrinkler.png"); //	29-Dec-2013 01:02	5.8K	 
			downloadFile("workerGrandma.png"); //	29-Dec-2013 01:02	534	 
			downloadFile("wrathContract.png"); //	31-Mar-2014 22:57	5.1K	 
			downloadFile("wrathCookie.png"); //	29-Dec-2013 01:02	4.8K	 
			downloadFile("wrinkler.png"); //	29-Dec-2013 01:02	5.8K	 
			downloadFile("wrinklerBits.png"); //	29-Dec-2013 01:02	6.4K	 
		}


		private function downloadFile(fileName:String):void
		{
			ResourceManager.gi.loadResource('http://orteil.dashnet.org/cookieclicker/img/' + fileName, loadResourceComplete, null, {fileName: fileName}, ResourceType.TYPE_BINARY);
		}

		private function loadResourceComplete(res:Resource):void
		{
			if (res.data)
			{
				trace('loadResourceComplete', res.url);
				var ba:ByteArray=res.data as ByteArray;
				var fileName:String=res['fileName'];
				var filePath:String='/Users/hufan/Documents/workspace/armorhu_git/CookiesClicker/doc/Cookies Clicker/img/' + fileName;
				FileUtil.writeFileWithByteArray(filePath, ba);
			}
		}
	}
}
