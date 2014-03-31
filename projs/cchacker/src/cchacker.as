package
{
	import com.agame.manager.load.ResourceManager;
	import com.agame.manager.load.resource.Resource;
	import com.agame.manager.load.resource.ResourceType;
	import com.amgame.utils.FileUtil;

	import flash.display.Sprite;
	import flash.filesystem.File;
	import flash.utils.ByteArray;

	/**
	 * 抓取cookies clicker的专用项目
	 * @author hufan
	 */
	public class cchacker extends Sprite
	{
		public function cchacker()
		{
			download(['perfectCookie.png', 'goldCookie.png', 'wrathCookie.png', 'spookyCookie.png', 'icons.png', 'cookieShower1.png', 'cookieShower2.png', 'cookieShower3.png', 'milkWave.png', 'chocolateMilkWave.png', 'raspberryWave.png', 'orangeWave.png', 'caramelWave.png', 'grandmas1.jpg', 'grandmas2.jpg', 'grandmas3.jpg', 'bgBlue.jpg', 'blackGradient.png', 'shine.png', 'shadedBorders.png', 'shadedBordersRed.png', 'shadedBordersGold.png', 'smallCookies.png', 'cursor.png', 'wrinkler.png', 'winterWrinkler.png', 'wrinklerBits.png', 'grandmaIcon.png', 'grandmaIconB.png', 'grandmaIconC.png', 'grandmaIconD.png', 'santa.png', 'frostedReindeer.png', 'snow2.jpg', 'winterFrame.png', 'hearts.png', 'heartStorm.png'])
		}


		public function download(names:Array):void
		{
			var len:int=names.length;
			for (var i:int=0; i < len; i++)
				downloadFile('http://orteil.dashnet.org/cookieclicker/img/' + names[i], names[i]);
		}

		private function downloadFile(url:String, fileName:String):void
		{
			trace('downloadFile', url);
			ResourceManager.gi.loadResource(url, loadResourceComplete, null, {fileName: fileName}, ResourceType.TYPE_BINARY);
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
