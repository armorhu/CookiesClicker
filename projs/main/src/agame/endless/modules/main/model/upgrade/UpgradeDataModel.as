package agame.endless.modules.main.model.upgrade
{
	import com.agame.services.csv.CSVFile;
	import com.agame.utils.choose;

	import flash.utils.ByteArray;

	import agame.endless.modules.main.model.Game;
	import agame.endless.services.assets.Assets;

	public class UpgradeDataModel
	{
		public function UpgradeDataModel()
		{
		}

		public static function setup():void
		{
			UpgradeData.csvFile=new CSVFile();
			var ba:ByteArray=Assets.current.getByteArray('upgrades');
			UpgradeData.csvFile.read(ba.readUTFBytes(ba.bytesAvailable)).parse();

			var len:int=UpgradeData.csvFile.valueTables.length;
			for (var i:int=0; i < len; i++)
				new UpgradeData();

			Assets.current.removeByteArray('upgrades');
			UpgradeData.csvFile.dispose();

			var tier1:int=10;
			var tier2:int=100;
			var tier3:int=1000;
			var tier4:int=50000;
			var tier5:int=1000000;

			order=100;

			createUpgrade('Reinforced index finger', 'The mouse gains <b>+1</b> cookie per click.<br>Cursors gain <b>+0.1</b> base CpS.<q>prod prod</q>', 100, [0, 0]);
			createUpgrade('Carpal tunnel prevention cream', 'The mouse and cursors are <b>twice</b> as efficient.<q>it... it hurts to click...</q>', 400, [0, 0]);
			createUpgrade('Ambidextrous', 'The mouse and cursors are <b>twice</b> as efficient.<q>Look ma, both hands!</q>', 10000, [0, 6]);
			createUpgrade('Thousand fingers', 'The mouse and cursors gain <b>+0.1</b> cookies for each non-cursor object owned.<q>clickity</q>', 500000, [0, 6]);
			createUpgrade('Million fingers', 'The mouse and cursors gain <b>+0.5</b> cookies for each non-cursor object owned.<q>clickityclickity</q>', 50000000, [1, 6]);
			createUpgrade('Billion fingers', 'The mouse and cursors gain <b>+2</b> cookies for each non-cursor object owned.<q>clickityclickityclickity</q>', 500000000, [2, 6]);
			createUpgrade('Trillion fingers', 'The mouse and cursors gain <b>+10</b> cookies for each non-cursor object owned.<q>clickityclickityclickityclickity</q>', 5000000000, [3, 6]);

			order=200;
			createUpgrade('Forwards from grandma', 'Grandmas gain <b>+0.3</b> base CpS.<q>RE:RE:thought you\'d get a kick out of this ;))</q>', Game.Objects['Grandma'].basePrice * tier1, [1, 0]);
			createUpgrade('Steel-plated rolling pins', 'Grandmas are <b>twice</b> as efficient.<q>Just what you kneaded.</q>', Game.Objects['Grandma'].basePrice * tier2, [1, 0]);
			createUpgrade('Lubricated dentures', 'Grandmas are <b>twice</b> as efficient.<q>squish</q>', Game.Objects['Grandma'].basePrice * tier3, [1, 1]);

			order=300;
			createUpgrade('Cheap hoes', 'Farms gain <b>+1</b> base CpS.<q>Rake in the dough!</q>', Game.Objects['Farm'].basePrice * tier1, [2, 0]);
			createUpgrade('Fertilizer', 'Farms are <b>twice</b> as efficient.<q>It\'s chocolate, I swear.</q>', Game.Objects['Farm'].basePrice * tier2, [2, 0]);
			createUpgrade('Cookie trees', 'Farms are <b>twice</b> as efficient.<q>A relative of the breadfruit.</q>', Game.Objects['Farm'].basePrice * tier3, [2, 1]);

			order=400;
			createUpgrade('Sturdier conveyor belts', 'Factories gain <b>+4</b> base CpS.<q>You\'re going places.</q>', Game.Objects['Factory'].basePrice * tier1, [4, 0]);
			createUpgrade('Child labor', 'Factories are <b>twice</b> as efficient.<q>Cheaper, healthier workforce.</q>', Game.Objects['Factory'].basePrice * tier2, [4, 0]);
			createUpgrade('Sweatshop', 'Factories are <b>twice</b> as efficient.<q>Slackers will be terminated.</q>', Game.Objects['Factory'].basePrice * tier3, [4, 1]);

			order=500;
			createUpgrade('Sugar gas', 'Mines gain <b>+10</b> base CpS.<q>A pink, volatile gas, found in the depths of some chocolate caves.</q>', Game.Objects['Mine'].basePrice * tier1, [3, 0]);
			createUpgrade('Megadrill', 'Mines are <b>twice</b> as efficient.<q>You\'re in deep.</q>', Game.Objects['Mine'].basePrice * tier2, [3, 0]);
			createUpgrade('Ultradrill', 'Mines are <b>twice</b> as efficient.<q>Finally caved in?</q>', Game.Objects['Mine'].basePrice * tier3, [3, 1]);

			order=600;
			createUpgrade('Vanilla nebulae', 'Shipments gain <b>+30</b> base CpS.<q>If you removed your space helmet, you could probably smell it!<br>(Note : don\'t do that.)</q>', Game.Objects['Shipment'].basePrice * tier1, [5, 0]);
			createUpgrade('Wormholes', 'Shipments are <b>twice</b> as efficient.<q>By using these as shortcuts, your ships can travel much faster.</q>', Game.Objects['Shipment'].basePrice * tier2, [5, 0]);
			createUpgrade('Frequent flyer', 'Shipments are <b>twice</b> as efficient.<q>Come back soon!</q>', Game.Objects['Shipment'].basePrice * tier3, [5, 1]);

			order=700;
			createUpgrade('Antimony', 'Alchemy labs gain <b>+100</b> base CpS.<q>Actually worth a lot of mony.</q>', Game.Objects['Alchemy lab'].basePrice * tier1, [6, 0]);
			createUpgrade('Essence of dough', 'Alchemy labs are <b>twice</b> as efficient.<q>Extracted through the 5 ancient steps of alchemical baking.</q>', Game.Objects['Alchemy lab'].basePrice * tier2, [6, 0]);
			createUpgrade('True chocolate', 'Alchemy labs are <b>twice</b> as efficient.<q>The purest form of cacao.</q>', Game.Objects['Alchemy lab'].basePrice * tier3, [6, 1]);

			order=800;
			createUpgrade('Ancient tablet', 'Portals gain <b>+1,666</b> base CpS.<q>A strange slab of peanut brittle, holding an ancient cookie recipe. Neat!</q>', Game.Objects['Portal'].basePrice * tier1, [7, 0]);
			createUpgrade('Insane oatling workers', 'Portals are <b>twice</b> as efficient.<q>ARISE, MY MINIONS!</q>', Game.Objects['Portal'].basePrice * tier2, [7, 0]);
			createUpgrade('Soul bond', 'Portals are <b>twice</b> as efficient.<q>So I just sign up and get more cookies? Sure, whatever!</q>', Game.Objects['Portal'].basePrice * tier3, [7, 1]);

			order=900;
			createUpgrade('Flux capacitors', 'Time machines gain <b>+9,876</b> base CpS.<q>Bake to the future.</q>', 1234567890, [8, 0]);
			createUpgrade('Time paradox resolver', 'Time machines are <b>twice</b> as efficient.<q>No more fooling around with your own grandmother!</q>', 9876543210, [8, 0]);
			createUpgrade('Quantum conundrum', 'Time machines are <b>twice</b> as efficient.<q>There is only one constant, and that is universal uncertainty.<br>Or is it?</q>', 98765456789, [8, 1]);

			order=20000;
			createUpgrade('Kitten helpers', 'You gain <b>more CpS</b> the more milk you have.<q>meow may I help you</q>', 9000000, [1, 7]);
			createUpgrade('Kitten workers', 'You gain <b>more CpS</b> the more milk you have.<q>meow meow meow meow</q>', 9000000000, [2, 7]);

			order=10000;
			type='cookie';
			power=5;
			createUpgrade('Oatmeal raisin cookies', 'Cookie production multiplier <b>+5%</b>.<q>No raisin to hate these.</q>', 99999999, [0, 3]);
			createUpgrade('Peanut butter cookies', 'Cookie production multiplier <b>+5%</b>.<q>Get yourself some jam cookies!</q>', 99999999, [1, 3]);
			createUpgrade('Plain cookies', 'Cookie production multiplier <b>+5%</b>.<q>Meh.</q>', 99999999, [2, 3]);
			createUpgrade('Coconut cookies', 'Cookie production multiplier <b>+5%</b>.<q>These are *way* flaky.</q>', 999999999, [3, 3]);
			createUpgrade('White chocolate cookies', 'Cookie production multiplier <b>+5%</b>.<q>I know what you\'ll say. It\'s just cocoa butter! It\'s not real chocolate!<br>Oh please.</q>', 999999999, [4, 3]);
			createUpgrade('Macadamia nut cookies', 'Cookie production multiplier <b>+5%</b>.<q>They\'re macadamn delicious!</q>', 999999999, [5, 3]);
			power=10;
			createUpgrade('Double-chip cookies', 'Cookie production multiplier <b>+10%</b>.<q>DOUBLE THE CHIPS<br>DOUBLE THE TASTY<br>(double the calories)</q>', 99999999999, [6, 3]);
			power=5;
			createUpgrade('Sugar cookies', 'Cookie production multiplier <b>+5%</b>.<q>Tasty, if a little unimaginative.</q>', 99999999, [7, 3]);
			power=10;
			createUpgrade('White chocolate macadamia nut cookies', 'Cookie production multiplier <b>+10%</b>.<q>Orteil\'s favorite.</q>', 99999999999, [8, 3]);
			createUpgrade('All-chocolate cookies', 'Cookie production multiplier <b>+10%</b>.<q>CHOCOVERDOSE.</q>', 99999999999, [9, 3]);
			type='';
			power=0;

			order=100;
			createUpgrade('Quadrillion fingers', 'The mouse and cursors gain <b>+20</b> cookies for each non-cursor object owned.<q>clickityclickityclickityclickityclick</q>', 50000000000, [3, 6]);

			order=200;
			createUpgrade('Prune juice', 'Grandmas are <b>twice</b> as efficient.<q>Gets me going.</q>', Game.Objects['Grandma'].basePrice * tier4, [1, 2]);
			order=300;
			createUpgrade('Genetically-modified cookies', 'Farms are <b>twice</b> as efficient.<q>All-natural mutations.</q>', Game.Objects['Farm'].basePrice * tier4, [2, 2]);
			order=400;
			createUpgrade('Radium reactors', 'Factories are <b>twice</b> as efficient.<q>Gives your cookies a healthy glow.</q>', Game.Objects['Factory'].basePrice * tier4, [4, 2]);
			order=500;
			createUpgrade('Ultimadrill', 'Mines are <b>twice</b> as efficient.<q>Pierce the heavens, etc.</q>', Game.Objects['Mine'].basePrice * tier4, [3, 2]);
			order=600;
			createUpgrade('Warp drive', 'Shipments are <b>twice</b> as efficient.<q>To boldly bake.</q>', Game.Objects['Shipment'].basePrice * tier4, [5, 2]);
			order=700;
			createUpgrade('Ambrosia', 'Alchemy labs are <b>twice</b> as efficient.<q>Adding this to the cookie mix is sure to make them even more addictive!<br>Perhaps dangerously so.<br>Let\'s hope you can keep selling these legally.</q>', Game.Objects['Alchemy lab'].basePrice * tier4, [6, 2]);
			order=800;
			createUpgrade('Sanity dance', 'Portals are <b>twice</b> as efficient.<q>We can change if we want to.<br>We can leave our brains behind.</q>', Game.Objects['Portal'].basePrice * tier4, [7, 2]);
			order=900;
			createUpgrade('Causality enforcer', 'Time machines are <b>twice</b> as efficient.<q>What happened, happened.</q>', 1234567890000, [8, 2]);

			order=5000;
			createUpgrade('Lucky day', 'Golden cookies appear <b>twice as often</b> and stay <b>twice as long</b>.<q>Oh hey, a four-leaf penny!</q>', 777777777, [10, 1]);
			createUpgrade('Serendipity', 'Golden cookies appear <b>twice as often</b> and stay <b>twice as long</b>.<q>What joy! Seven horseshoes!</q>', 77777777777, [10, 1]);

			order=20000;
			createUpgrade('Kitten engineers', 'You gain <b>more CpS</b> the more milk you have.<q>meow meow meow meow, sir</q>', 9000000000000, [3, 7]);

			order=10000;
			type='cookie';
			power=15;
			createUpgrade('Dark chocolate-coated cookies', 'Cookie production multiplier <b>+15%</b>.<q>These absorb light so well you almost need to squint to see them.</q>', 999999999999, [10, 3]);
			createUpgrade('White chocolate-coated cookies', 'Cookie production multiplier <b>+15%</b>.<q>These dazzling cookies absolutely glisten with flavor.</q>', 999999999999, [11, 3]);
			type='';
			power=0;

			order=250;
			createUpgrade('Farmer grandmas', 'Grandmas are <b>twice</b> as efficient.<q>A nice farmer to grow more cookies.</q>', Game.Objects['Farm'].basePrice * tier2, [10, 9], function():void
			{
				Game.Objects['Grandma'].drawFunction();
			});
			createUpgrade('Worker grandmas', 'Grandmas are <b>twice</b> as efficient.<q>A nice worker to manufacture more cookies.</q>', Game.Objects['Factory'].basePrice * tier2, [10, 9], function():void
			{
				Game.Objects['Grandma'].drawFunction();
			});
			createUpgrade('Miner grandmas', 'Grandmas are <b>twice</b> as efficient.<q>A nice miner to dig more cookies.</q>', Game.Objects['Mine'].basePrice * tier2, [10, 9], function():void
			{
				Game.Objects['Grandma'].drawFunction();
			});
			createUpgrade('Cosmic grandmas', 'Grandmas are <b>twice</b> as efficient.<q>A nice thing to... uh... cookies.</q>', Game.Objects['Shipment'].basePrice * tier2, [10, 9], function():void
			{
				Game.Objects['Grandma'].drawFunction();
			});
			createUpgrade('Transmuted grandmas', 'Grandmas are <b>twice</b> as efficient.<q>A nice golden grandma to convert into more cookies.</q>', Game.Objects['Alchemy lab'].basePrice * tier2, [10, 9], function():void
			{
				Game.Objects['Grandma'].drawFunction();
			});
			createUpgrade('Altered grandmas', 'Grandmas are <b>twice</b> as efficient.<q>a NiCe GrAnDmA tO bA##########</q>', Game.Objects['Portal'].basePrice * tier2, [10, 9], function():void
			{
				Game.Objects['Grandma'].drawFunction();
			});
			createUpgrade('Grandmas\' grandmas', 'Grandmas are <b>twice</b> as efficient.<q>A nice grandma\'s nice grandma to bake double the cookies.</q>', Game.Objects['Time machine'].basePrice * tier2, [10, 9], function():void
			{
				Game.Objects['Grandma'].drawFunction();
			});

			order=14000;
			Game.baseResearchTime=Game.fps * 60 * 30;

			createUpgrade('Bingo center/Research facility', 'Grandma-operated science lab and leisure club.<br>Grandmas are <b>4 times</b> as efficient.<br><b>Regularly unlocks new upgrades</b>.<q>What could possibly keep those grandmothers in check?...<br>Bingo.</q>', 100000000000, [11, 9], function():void
			{
				Game.SetResearch('Specialized chocolate chips');
			});

			order=15000;

			createUpgrade('Specialized chocolate chips', '[Research]<br>Cookie production multiplier <b>+1%</b>.<q>Computer-designed chocolate chips. Computer chips, if you will.</q>', 10000000000, [0, 9], function():void
			{
				Game.SetResearch('Designer cocoa beans');
			});
			createUpgrade('Designer cocoa beans', '[Research]<br>Cookie production multiplier <b>+2%</b>.<q>Now more aerodynamic than ever!</q>', 20000000000, [1, 9], function():void
			{
				Game.SetResearch('Ritual rolling pins');
			});
			createUpgrade('Ritual rolling pins', '[Research]<br>Grandmas are <b>twice</b> as efficient.<q>The result of years of scientific research!</q>', 40000000000, [2, 9], function():void
			{
				Game.SetResearch('Underworld ovens');
			});
			createUpgrade('Underworld ovens', '[Research]<br>Cookie production multiplier <b>+3%</b>.<q>Powered by science, of course!</q>', 80000000000, [3, 9], function():void
			{
				Game.SetResearch('One mind');
			});
			createUpgrade('One mind', '[Research]<br>Each grandma gains <b>+1 base CpS for every 50 grandmas</b>.<div class="warning">Note : the grandmothers are growing restless. Do not encourage them.</div><q>We are one. We are many.</q>', 160000000000, [4, 9], function():void
			{
				Game.elderWrath=1;
				Game.SetResearch('Exotic nuts');
			});
			Game.Upgrades['One mind'].clickFunction=function():Boolean
			{
				return Game.confirm('Warning : purchasing this will have unexpected, and potentially undesirable results!\nIt\'s all downhill from here. You have been warned!\nPurchase anyway?');
			};
			createUpgrade('Exotic nuts', '[Research]<br>Cookie production multiplier <b>+4%</b>.<q>You\'ll go crazy over these!</q>', 320000000000, [5, 9], function():void
			{
				Game.SetResearch('Communal brainsweep');
			});
			createUpgrade('Communal brainsweep', '[Research]<br>Each grandma gains another <b>+1 base CpS for every 50 grandmas</b>.<div class="warning">Note : proceeding any further in scientific research may have unexpected results. You have been warned.</div><q>We fuse. We merge. We grow.</q>', 640000000000, [6, 9], function():void
			{
				Game.elderWrath=2;
				Game.SetResearch('Arcane sugar');
			});
			createUpgrade('Arcane sugar', '[Research]<br>Cookie production multiplier <b>+5%</b>.<q>Tastes like insects, ligaments, and molasses.</q>', 1280000000000, [7, 9], function():void
			{
				Game.SetResearch('Elder Pact');
			});
			createUpgrade('Elder Pact', '[Research]<br>Each grandma gains <b>+1 base CpS for every 20 portals</b>.<div class="warning">Note : this is a bad idea.</div><q>squirm crawl slither writhe<br>today we rise</q>', 2560000000000, [8, 9], function():void
			{
				Game.elderWrath=3;
			});
			createUpgrade('Elder Pledge', '[Repeatable]<br>Contains the wrath of the elders, at least for a while.<q>This is a simple ritual involving anti-aging cream, cookie batter mixed in the moonlight, and a live chicken.</q>', 1, [9, 9], function():void
			{
				Game.elderWrath=0;
				Game.pledges++;
				Game.pledgeT=Game.fps * 60 * (Game.Has('Sacrificial rolling pins') ? 60 : 30);
				Game.Upgrades['Elder Pledge'].basePrice=Math.pow(8, Math.min(Game.pledges + 2, 14));
				Game.Unlock('Elder Covenant');
				Game.CollectWrinklers();
			});
			Game.Upgrades['Elder Pledge'].hide=3;

			order=150;
			createUpgrade('Plastic mouse', 'Clicking gains <b>+1% of your CpS</b>.<q>Slightly squeaky.</q>', 50000, [11, 0]);
			createUpgrade('Iron mouse', 'Clicking gains <b>+1% of your CpS</b>.<q>Click like it\'s 1349!</q>', 5000000, [11, 0]);
			createUpgrade('Titanium mouse', 'Clicking gains <b>+1% of your CpS</b>.<q>Heavy, but powerful.</q>', 500000000, [11, 1]);
			createUpgrade('Adamantium mouse', 'Clicking gains <b>+1% of your CpS</b>.<q>You could cut diamond with these.</q>', 50000000000, [11, 2]);

			order=40000;
			createUpgrade('Ultrascience', 'Research takes only <b>5 seconds</b>.<q>YEAH, SCIENCE!</q>', 7, [9, 2]); //debug purposes only
			Game.Upgrades['Ultrascience'].hide=3;
			Game.Upgrades['Ultrascience'].debug=1;

			order=10000;
			type='cookie';
			power=15;
			createUpgrade('Eclipse cookies', 'Cookie production multiplier <b>+15%</b>.<q>Look to the cookie.</q>', 9999999999999, [0, 4]);
			createUpgrade('Zebra cookies', 'Cookie production multiplier <b>+15%</b>.<q>...</q>', 9999999999999, [1, 4]);
			type='';
			power=0;

			order=100;
			createUpgrade('Quintillion fingers', 'The mouse and cursors gain <b>+100</b> cookies for each non-cursor object owned.<q>man, just go click click click click click, it\'s real easy, man.</q>', 50000000000000, [3, 6]);

			order=40000;
			createUpgrade('Gold hoard', 'Golden cookies appear <b>really often</b>.<q>That\'s entirely too many.</q>', 7, [10, 1]); //debug purposes only
			Game.Upgrades['Gold hoard'].hide=3;
			Game.Upgrades['Gold hoard'].debug=1;

			order=15000;
			createUpgrade('Elder Covenant', '[Switch]<br>Puts a permanent end to the elders\' wrath, at the price of 5% of your CpS.<q>This is a complicated ritual involving silly, inconsequential trivialities such as cursed laxatives, century-old cacao, and an infant.<br>Don\'t question it.</q>', 66666666666666, [8, 9], function():void
			{
				Game.pledgeT=0;
				Game.Lock('Revoke Elder Covenant');
				Game.Unlock('Revoke Elder Covenant');
				Game.Lock('Elder Pledge');
				Game.Win('Elder calm');
				Game.CollectWrinklers();
			});
			Game.Upgrades['Elder Covenant'].hide=3;

			createUpgrade('Revoke Elder Covenant', '[Switch]<br>You will get 5% of your CpS back, but the grandmatriarchs will return.<q>we<br>rise<br>again</q>', 6666666666, [8, 9], function():void
			{
				Game.Lock('Elder Covenant');
				Game.Unlock('Elder Covenant');
			});
			Game.Upgrades['Revoke Elder Covenant'].hide=3;

			order=5000;
			createUpgrade('Get lucky', 'Golden cookie effects last <b>twice as long</b>.<q>You\'ve been up all night, haven\'t you?</q>', 77777777777777, [10, 1]);

			order=15000;
			createUpgrade('Sacrificial rolling pins', 'Elder pledge last <b>twice</b> as long.<q>These are mostly for spreading the anti-aging cream.<br>(and accessorily, shortening the chicken\'s suffering.)</q>', 2888888888888, [2, 9]);

			order=10000;
			type='cookie';
			power=15;
			createUpgrade('Snickerdoodles', 'Cookie production multiplier <b>+15%</b>.<q>True to their name.</q>', 99999999999999, [2, 4]);
			createUpgrade('Stroopwafels', 'Cookie production multiplier <b>+15%</b>.<q>If it ain\'t dutch, it ain\'t much.</q>', 99999999999999, [3, 4]);
			createUpgrade('Macaroons', 'Cookie production multiplier <b>+15%</b>.<q>Not to be confused with macarons.<br>These have coconut, okay?</q>', 99999999999999, [4, 4]);
			type='';
			power=0;

			order=40000;
			createUpgrade('Neuromancy', 'Can toggle upgrades on and off at will in the stats menu.<q>Can also come in handy to unsee things that can\'t be unseen.</q>', 7, [4, 9]); //debug purposes only
			Game.Upgrades['Neuromancy'].hide=3;
			Game.Upgrades['Neuromancy'].debug=1;

			order=10000;
			type='cookie';
			power=15;
			createUpgrade('Empire biscuits', 'Cookie production multiplier <b>+15%</b>.<q>For your growing cookie empire, of course!</q>', 99999999999999, [5, 4]);
			createUpgrade('British tea biscuits', 'Cookie production multiplier <b>+15%</b>.<q>Quite.</q>', 99999999999999, [6, 4]);
			createUpgrade('Chocolate british tea biscuits', 'Cookie production multiplier <b>+15%</b>.<q>Yes, quite.</q>', 99999999999999, [7, 4]);
			createUpgrade('Round british tea biscuits', 'Cookie production multiplier <b>+15%</b>.<q>Yes, quite riveting.</q>', 99999999999999, [8, 4]);
			createUpgrade('Round chocolate british tea biscuits', 'Cookie production multiplier <b>+15%</b>.<q>Yes, quite riveting indeed.</q>', 99999999999999, [9, 4]);
			createUpgrade('Round british tea biscuits with heart motif', 'Cookie production multiplier <b>+15%</b>.<q>Yes, quite riveting indeed, old chap.</q>', 99999999999999, [10, 4]);
			createUpgrade('Round chocolate british tea biscuits with heart motif', 'Cookie production multiplier <b>+15%</b>.<q>I like cookies.</q>', 99999999999999, [11, 4]);
			type='';
			power=0;


			order=1000;
			createUpgrade('Sugar bosons', 'Antimatter condensers gain <b>+99,999</b> base CpS.<q>Sweet firm bosons.</q>', Game.Objects['Antimatter condenser'].basePrice * tier1, [13, 0]);
			createUpgrade('String theory', 'Antimatter condensers are <b>twice</b> as efficient.<q>Reveals new insight about the true meaning of baking cookies (and, as a bonus, the structure of the universe).</q>', Game.Objects['Antimatter condenser'].basePrice * tier2, [13, 0]);
			createUpgrade('Large macaron collider', 'Antimatter condensers are <b>twice</b> as efficient.<q>How singular!</q>', Game.Objects['Antimatter condenser'].basePrice * tier3, [13, 1]);
			createUpgrade('Big bang bake', 'Antimatter condensers are <b>twice</b> as efficient.<q>And that\'s how it all began.</q>', Game.Objects['Antimatter condenser'].basePrice * tier4, [13, 2]);

			order=250;
			createUpgrade('Antigrandmas', 'Grandmas are <b>twice</b> as efficient.<q>A mean antigrandma to vomit more cookies.<br>(Do not put in contact with normal grandmas; loss of matter may occur.)</q>', Game.Objects['Antimatter condenser'].basePrice * tier2, [10, 9], function():void
			{
				Game.Objects['Grandma'].drawFunction();
			});

			order=10000;
			type='cookie';
			power=20;
			createUpgrade('Madeleines', 'Cookie production multiplier <b>+20%</b>.<q>Unforgettable!</q>', 199999999999999, [12, 3]);
			createUpgrade('Palmiers', 'Cookie production multiplier <b>+20%</b>.<q>Palmier than you!<br>Yes, I just said that.</q>', 199999999999999, [13, 3]);
			createUpgrade('Palets', 'Cookie production multiplier <b>+20%</b>.<q>You could probably play hockey with these.<br>I mean, you\'re welcome to try.</q>', 199999999999999, [12, 4]);
			createUpgrade('Sabl&eacute;s', 'Cookie production multiplier <b>+20%</b>.<q>The name implies they\'re made of sand. But you know better, don\'t you?</q>', 199999999999999, [13, 4]);
			type='';
			power=0;

			order=20000;
			createUpgrade('Kitten overseers', 'You gain <b>more CpS</b> the more milk you have.<q>my purrpose is to serve you, sir</q>', 900000000000000, [8, 7]);


			order=100;
			createUpgrade('Sextillion fingers', 'The mouse and cursors gain <b>+200</b> cookies for each non-cursor object owned.<q>sometimes<br>things just<br>click</q>', 500000000000000, [12, 13]);

			order=200;
			createUpgrade('Double-thick glasses', 'Grandmas are <b>twice</b> as efficient.<q>Oh... so THAT\'s what I\'ve been baking.</q>', Game.Objects['Grandma'].basePrice * tier5, [1, 13]);
			order=300;
			createUpgrade('Gingerbread scarecrows', 'Farms are <b>twice</b> as efficient.<q>Staring at your crops with mischievous glee.</q>', Game.Objects['Farm'].basePrice * tier5, [2, 13]);
			order=400;
			createUpgrade('Recombobulators', 'Factories are <b>twice</b> as efficient.<q>A major part of cookie recombobulation.</q>', Game.Objects['Factory'].basePrice * tier5, [4, 13]);
			order=500;
			createUpgrade('H-bomb mining', 'Mines are <b>twice</b> as efficient.<q>Questionable efficiency, but spectacular nonetheless.</q>', Game.Objects['Mine'].basePrice * tier5, [3, 13]);
			order=600;
			createUpgrade('Chocolate monoliths', 'Shipments are <b>twice</b> as efficient.<q>My god. It\'s full of chocolate bars.</q>', Game.Objects['Shipment'].basePrice * tier5, [5, 13]);
			order=700;
			createUpgrade('Aqua crustulae', 'Alchemy labs are <b>twice</b> as efficient.<q>Careful with the dosing - one drop too much and you get muffins.<br>And nobody likes muffins.</q>', Game.Objects['Alchemy lab'].basePrice * tier5, [6, 13]);
			order=800;
			createUpgrade('Brane transplant', 'Portals are <b>twice</b> as efficient.<q>This refers to the practice of merging higher dimensional universes, or "branes", with our own, in order to facilitate transit (and harvesting of precious cookie dough).</q>', Game.Objects['Portal'].basePrice * tier5, [7, 13]);
			order=900;
			createUpgrade('Yestermorrow comparators', 'Time machines are <b>twice</b> as efficient.<q>Fortnights into milleniums.</q>', Game.Objects['Time machine'].basePrice * tier5, [8, 13]);
			order=1000;
			createUpgrade('Reverse cyclotrons', 'Antimatter condensers are <b>twice</b> as efficient.<q>These can uncollision particles and unspin atoms. For... uh... better flavor, and stuff.</q>', Game.Objects['Antimatter condenser'].basePrice * tier5, [13, 13]);

			order=150;
			createUpgrade('Unobtainium mouse', 'Clicking gains <b>+1% of your CpS</b>.<q>These nice mice should suffice.</q>', 5000000000000, [11, 13]);

			order=10000;
			type='cookie';
			power=25;
			createUpgrade('Caramoas', 'Cookie production multiplier <b>+25%</b>.<q>Yeah. That\'s got a nice ring to it.</q>', 999999999999999, [14, 4]);
			createUpgrade('Sagalongs', 'Cookie production multiplier <b>+25%</b>.<q>Grandma\'s favorite?</q>', 999999999999999, [15, 3]);
			createUpgrade('Shortfoils', 'Cookie production multiplier <b>+25%</b>.<q>Foiled again!</q>', 999999999999999, [15, 4]);
			createUpgrade('Win mints', 'Cookie production multiplier <b>+25%</b>.<q>They\'re the luckiest cookies you\'ve ever tasted!</q>', 999999999999999, [14, 3]);
			type='';
			power=0;

			order=40000;
			createUpgrade('Perfect idling', 'You keep producing cookies even while the game is closed.<q>It\'s the most beautiful thing I\'ve ever seen.</q>', 7, [10, 0]); //debug purposes only
			Game.Upgrades['Perfect idling'].hide=3;
			Game.Upgrades['Perfect idling'].debug=1;

			order=10000;
			type='cookie';
			power=25;
			createUpgrade('Fig gluttons', 'Cookie production multiplier <b>+25%</b>.<q>Got it all figured out.</q>', 999999999999999, [17, 4]);
			createUpgrade('Loreols', 'Cookie production multiplier <b>+25%</b>.<q>Because, uh... they\'re worth it?</q>', 999999999999999, [16, 3]);
			createUpgrade('Jaffa cakes', 'Cookie production multiplier <b>+25%</b>.<q>If you want to bake a cookie from scratch, you must first build a factory.</q>', 999999999999999, [17, 3]);
			createUpgrade('Grease\'s cups', 'Cookie production multiplier <b>+25%</b>.<q>Extra-greasy peanut butter.</q>', 999999999999999, [16, 4]);
			type='';
			power=0;

			order=30000;
			createUpgrade('Heavenly chip secret', 'Unlocks <b>5%</b> of the potential of your heavenly chips.<q>Grants the knowledge of heavenly chips, and how to use them to make baking more efficient.<br>It\'s a secret to everyone.</q>', 11, [19, 7]);
			createUpgrade('Heavenly cookie stand', 'Unlocks <b>25%</b> of the potential of your heavenly chips.<q>Don\'t forget to visit the heavenly lemonade stand afterwards.</q>', 1111, [18, 7]);
			createUpgrade('Heavenly bakery', 'Unlocks <b>50%</b> of the potential of your heavenly chips.<q>Also sells godly cakes and divine pastries.</q>', 111111, [17, 7]);
			createUpgrade('Heavenly confectionery', 'Unlocks <b>75%</b> of the potential of your heavenly chips.<q>They say angel bakers work there. They take angel lunch breaks and sometimes go on angel strikes.</q>', 11111111, [16, 7]);
			createUpgrade('Heavenly key', 'Unlocks <b>100%</b> of the potential of your heavenly chips.<q>This is the key to the pearly (and tasty) gates of pastry heaven, granting you access to your entire stockpile of heavenly chips.<br>May you use them wisely.</q>', 1111111111, [15, 7]);

			order=10100;
			type='cookie';
			power=20;
			createUpgrade('Skull cookies', 'Cookie production multiplier <b>+20%</b>.<q>Wanna know something spooky? You\'ve got one of these inside your head RIGHT NOW.</q>', 444444444444, [12, 8]);
			createUpgrade('Ghost cookies', 'Cookie production multiplier <b>+20%</b>.<q>They\'re something strange, but they look pretty good!</q>', 444444444444, [13, 8]);
			createUpgrade('Bat cookies', 'Cookie production multiplier <b>+20%</b>.<q>The cookies this town deserves.</q>', 444444444444, [14, 8]);
			createUpgrade('Slime cookies', 'Cookie production multiplier <b>+20%</b>.<q>The incredible melting cookies!</q>', 444444444444, [15, 8]);
			createUpgrade('Pumpkin cookies', 'Cookie production multiplier <b>+20%</b>.<q>Not even pumpkin-flavored. Tastes like glazing. Yeugh.</q>', 444444444444, [16, 8]);
			createUpgrade('Eyeball cookies', 'Cookie production multiplier <b>+20%</b>.<q>When you stare into the cookie, the cookie stares back at you.</q>', 444444444444, [17, 8]);
			createUpgrade('Spider cookies', 'Cookie production multiplier <b>+20%</b>.<q>You found the recipe on the web. They do whatever a cookie can.</q>', 444444444444, [18, 8]);
			type='';
			power=0;

			order=14000;
			createUpgrade('Persistent memory', 'Subsequent research will be <b>10 times</b> as fast.<q>It\'s all making sense!<br>Again!</q>', 100000000000, [9, 2]);

			order=40000;
			createUpgrade('Wrinkler doormat', 'Wrinklers spawn much more frequently.<q>You\'re such a pushover.</q>', 7, [19, 8]); //debug purposes only
			Game.Upgrades['Wrinkler doormat'].hide=3;
			Game.Upgrades['Wrinkler doormat'].debug=1;

			order=10200;
			type='cookie';
			power=20;
			createUpgrade('Christmas tree biscuits', 'Cookie production multiplier <b>+20%</b>.<q>Whose pine is it anyway?</q>', 252525252525, [12, 10]);
			createUpgrade('Snowflake biscuits', 'Cookie production multiplier <b>+20%</b>.<q>Mass-produced to be unique in every way.</q>', 252525252525, [13, 10]);
			createUpgrade('Snowman biscuits', 'Cookie production multiplier <b>+20%</b>.<q>It\'s frosted. Doubly so.</q>', 252525252525, [14, 10]);
			createUpgrade('Holly biscuits', 'Cookie production multiplier <b>+20%</b>.<q>You don\'t smooch under these ones. That would be the mistletoe (which, botanically, is a smellier variant of the mistlefinger).</q>', 252525252525, [15, 10]);
			createUpgrade('Candy cane biscuits', 'Cookie production multiplier <b>+20%</b>.<q>It\'s two treats in one!<br>(Further inspection reveals the frosting does not actually taste like peppermint, but like mundane sugary frosting.)</q>', 252525252525, [16, 10]);
			createUpgrade('Bell biscuits', 'Cookie production multiplier <b>+20%</b>.<q>What do these even have to do with christmas? Who cares, ring them in!</q>', 252525252525, [17, 10]);
			createUpgrade('Present biscuits', 'Cookie production multiplier <b>+20%</b>.<q>The prequel to future biscuits. Watch out!</q>', 252525252525, [18, 10]);
			type='';
			power=0;

			order=10000;
			type='cookie';
			power=25;
			createUpgrade('Gingerbread men', 'Cookie production multiplier <b>+25%</b>.<q>You like to bite the legs off first, right? How about tearing off the arms? You sick monster.</q>', 9999999999999999, [18, 4]);
			createUpgrade('Gingerbread trees', 'Cookie production multiplier <b>+25%</b>.<q>Evergreens in pastry form. Yule be surprised what you can come up with.</q>', 9999999999999999, [18, 3]);
			type='';
			power=0;

			order=25000;
			createUpgrade('A festive hat', '<b>Unlocks... something.</b><q>Not a creature was stirring, not even a mouse.</q>', 25, [19, 9], function():void
			{
				var drop:String=choose(Game.santaDrops);
				Game.Unlock(drop);
				Game.Popup('In the festive hat, you find...<br>a festive test tube<br>and ' + drop + '.');
			});

			createUpgrade('Increased merriness', 'Cookie production multiplier <b>+15%</b>.<q>It turns out that the key to increased merriness, strangely enough, happens to be a good campfire and some s\'mores.<br>You know what they say, after all; the s\'more, the merrier.</q>', 2525, [17, 9]);
			createUpgrade('Improved jolliness', 'Cookie production multiplier <b>+15%</b>.<q>A nice wobbly belly goes a long way.<br>You jolly?</q>', 2525, [17, 9]);
			createUpgrade('A lump of coal', 'Cookie production multiplier <b>+1%</b>.<q>Some of the world\'s worst stocking stuffing.<br>I guess you could try starting your own little industrial revolution, or something?...</q>', 2525, [13, 9]);
			createUpgrade('An itchy sweater', 'Cookie production multiplier <b>+1%</b>.<q>You don\'t know what\'s worse : the embarrassingly quaint "elf on reindeer" motif, or the fact that wearing it makes you feel like you\'re wrapped in a dead sasquatch.</q>', 2525, [14, 9]);
			createUpgrade('Reindeer baking grounds', 'Reindeer appear <b>twice as frequently</b>.<q>Male reindeer are from Mars; female reindeer are from venison.</q>', 2525, [12, 9]);
			createUpgrade('Weighted sleighs', 'Reindeer are <b>twice as slow</b>.<q>Hope it was worth the weight.<br>(Something something forced into cervidude)</q>', 2525, [12, 9]);
			createUpgrade('Ho ho ho-flavored frosting', 'Reindeer give <b>twice as much</b>.<q>It\'s time to up the antler.</q>', 2525, [12, 9]);
			createUpgrade('Season savings', 'All buildings are <b>1% cheaper</b>.<q>By Santa\'s beard, what savings!<br>But who will save us?</q>', 2525, [16, 9], function():void
			{
				Game.RefreshBuildings();
			});
			createUpgrade('Toy workshop', 'All upgrades are <b>5% cheaper</b>.<q>Watch yours-elf around elvesdroppers who might steal our production secrets.<br>Or elven worse!</q>', 2525, [16, 9], function():void
			{
				Game.rebuildUpgrades();
			});
			createUpgrade('Naughty list', 'Grandmas are <b>twice</b> as productive.<q>This list contains every unholy deed perpetuated by grandmakind.<br>He won\'t be checking this one twice.<br>Once. Once is enough.</q>', 2525, [15, 9]);
			createUpgrade('Santa\'s bottomless bag', 'Random drops are <b>10% more common</b>.<q>This is one bottom you can\'t check out.</q>', 2525, [19, 9]);
			createUpgrade('Santa\'s helpers', 'Clicking is <b>10% more powerful</b>.<q>Some choose to help hamburger; some choose to help you.<br>To each their own, I guess.</q>', 2525, [19, 9]);
			createUpgrade('Santa\'s legacy', 'Cookie production multiplier <b>+10% per Santa\'s levels</b>.<q>In the north pole, you gotta get the elves first. Then when you get the elves, you start making the toys. Then when you get the toys... then you get the cookies.</q>', 2525, [19, 9]);
			createUpgrade('Santa\'s milk and cookies', 'Milk is <b>5% more powerful</b>.<q>Part of Santa\'s dreadfully unbalanced diet.</q>', 2525, [19, 9]);

			order=40000;
			createUpgrade('Reindeer season', 'Reindeer spawn much more frequently.<q>Go, Cheater! Go, Hacker and Faker!</q>', 7, [12, 9]); //debug purposes only
			Game.Upgrades['Reindeer season'].hide=3;
			Game.Upgrades['Reindeer season'].debug=1;

			order=25000;
			createUpgrade('Santa\'s dominion', 'Cookie production multiplier <b>+50%</b>.<br>All buildings are <b>1% cheaper</b>.<br>All upgrades are <b>2% cheaper</b>.<q>My name is Claus, king of kings;<br>Look on my toys, ye Mighty, and despair!</q>', 2525252525252525, [19, 10], function():void
			{
				Game.RefreshBuildings();
				Game.rebuildUpgrades();
			});

			order=10300;
			type='cookie';
			power=25;
			createUpgrade('Pure heart biscuits', 'Cookie production multiplier <b>+25%</b>.<q>Melty white chocolate<br>that says "I *like* like you".</q>', 9999999999999999, [19, 3]);
			createUpgrade('Ardent heart biscuits', 'Cookie production multiplier <b>+25%</b>.<q>A red hot cherry biscuit that will nudge the target of your affection in interesting directions.</q>', 9999999999999999, [20, 3]);
			createUpgrade('Sour heart biscuits', 'Cookie production multiplier <b>+25%</b>.<q>A bitter lime biscuit for the lonely and the heart-broken.</q>', 9999999999999999, [20, 4]);
			createUpgrade('Weeping heart biscuits', 'Cookie production multiplier <b>+25%</b>.<q>An ice-cold blueberry biscuit, symbol of a mending heart.</q>', 9999999999999999, [21, 3]);
			createUpgrade('Golden heart biscuits', 'Cookie production multiplier <b>+25%</b>.<q>A beautiful biscuit to symbolize kindness, true love, and sincerity.</q>', 9999999999999999, [21, 4]);
			createUpgrade('Eternal heart biscuits', 'Cookie production multiplier <b>+25%</b>.<q>Silver icing for a very special someone you\'ve liked for a long, long time.</q>', 9999999999999999, [19, 4]);
			type='';
			power=0;

			order=1100;
			createUpgrade('Gem polish', 'Prisms gain <b>+1,000,000</b> base CpS.<q>Get rid of the grime and let more light in.<br>Truly, truly outrageous.</q>', Game.Objects['Prism'].basePrice * tier1, [14, 0]);
			createUpgrade('9th color', 'Prisms are <b>twice</b> as efficient.<q>Delve into untouched optical depths where even the mantis shrimp hasn\'t set an eye!</q>', Game.Objects['Prism'].basePrice * tier2, [14, 0]);
			createUpgrade('Chocolate light', 'Prisms are <b>twice</b> as efficient.<q>Bask into its cocoalescence.<br>(Warning : may cause various interesting albeit deadly skin conditions.)</q>', Game.Objects['Prism'].basePrice * tier3, [14, 1]);
			createUpgrade('Grainbow', 'Prisms are <b>twice</b> as efficient.<q>Remember the different grains using the handy Roy G. Biv mnemonic : R is for rice, O is for oats... uh, B for barley?...</q>', Game.Objects['Prism'].basePrice * tier4, [14, 2]);
			createUpgrade('Pure cosmic light', 'Prisms are <b>twice</b> as efficient.<q>Your prisms now receive pristine, unadulterated photons from the other end of the universe.</q>', Game.Objects['Prism'].basePrice * tier5, [14, 13]);

			order=250;
			createUpgrade('Rainbow grandmas', 'Grandmas are <b>twice</b> as efficient.<q>A luminous grandma to sparkle into cookies.</q>', Game.Objects['Prism'].basePrice * tier2, [10, 9], function():void
			{
				Game.Objects['Grandma'].drawFunction();
			});

			order=24000;

			trace('setup upgrades complete,total=' + UpgradeData.UpgradesN);
		}

		public static var order:int;
		public static var type:String;
		public static var power:int;

		public static function createUpgrade(name:String, desc:String, price:Number, icon:Array, buyFunction:Function=null):void
		{
			if (buyFunction)
				Game.Upgrades[name].buyFunction=buyFunction;
		}
	}
}
