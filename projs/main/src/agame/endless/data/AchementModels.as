package agame.endless.data
{
	import com.agame.utils.Beautify;

	public class AchementModels
	{
		public function AchementModels()
		{
		}

		private var csvContext:String;

		public function setup():String
		{
			csvContext='';
			var id=1;
			var keys:Array=['id', 'name', 'displayName', 'desc', 'iconX', 'iconY', 'hide', 'order', 'category'];
			var types:Array=['int', 'String', 'String', 'int', 'int', 'String', 'int', 'int', 'String'];
			csvContext=csvContext + keys.join(',') + '\n';
			csvContext=csvContext + types.join(',') + '\n';
			function Achievement(name, desc, icon, hide=0, category='none')
			{
				var obj:*={};
				obj.id=id++;
				obj.name=name;
				obj.displayName=TextData.formatAndPush('ACH_displayName_' + obj.name, name);
				obj.desc=TextData.formatAndPush('ACH_Desc_' + obj.name, desc);
				obj.icon=icon;
				obj.won=0;
				obj.disabled=0;
				obj.hide=hide || 0; //hide levels : 0=show, 1=hide description, 2=hide, 3=secret (doesn't count toward achievement total)
				obj.order=order;
				obj.category=category;
				var temp:Array=[];
				temp.push(obj.id);
				temp.push(obj.name);
				temp.push(obj.displayName);
				temp.push('"' + obj.desc + '"');
				temp.push(obj.icon[0]);
				temp.push(obj.icon[1]);
				temp.push(obj.hide);
				temp.push(obj.order);
				temp.push(obj.category);
				csvContext=csvContext + temp.join(',') + '\n';
				return obj;
			}





			var order=100; //this is used to set the order in which the items are listed
			//Achievement('name','description',[0,0]);
			var moneyAchievs=['Wake and bake', 1, 'Making some dough', 100, 'So baked right now', 1000, 'Fledgling bakery', 10000, 'Affluent bakery', 100000, 'World-famous bakery', 1000000, 'Cosmic bakery', 10000000, 'Galactic bakery', 100000000, 'Universal bakery', 1000000000, 'Timeless bakery', 10000000000, 'Infinite bakery', 100000000000, 'Immortal bakery', 1000000000000, 'You can stop now', 10000000000000, 'Cookies all the way down', 100000000000000, 'Overdose', 1000000000000000, 'How?', 10000000000000000];
			for (var i=0; i < moneyAchievs.length / 2; i++)
			{
				var pic=[Math.min(10, i), 5];
				if (i == 15)
					pic=[11, 5];
				Achievement(moneyAchievs[i * 2], 'Bake <b>' + Beautify(moneyAchievs[i * 2 + 1]) + '</b> cookie' + (moneyAchievs[i * 2 + 1] == 1 ? '' : 's') + '.', pic, 2, 'money');
			}

			order=200;
			var cpsAchievs=['Casual baking', 1, 'Hardcore baking', 10, 'Steady tasty stream', 100, 'Cookie monster', 1000, 'Mass producer', 10000, 'Cookie vortex', 1000000, 'Cookie pulsar', 10000000, 'Cookie quasar', 100000000, 'A world filled with cookies', 10000000000, 'Let\'s never bake again', 1000000000000];
			for (var i=0; i < cpsAchievs.length / 2; i++)
			{
				var pic=[i, 5];
				Achievement(cpsAchievs[i * 2], 'Bake <b>' + Beautify(cpsAchievs[i * 2 + 1]) + '</b> cookie' + (cpsAchievs[i * 2 + 1] == 1 ? '' : 's') + ' per second.', pic, 2, 'cps');
			}

			order=30000;
			Achievement('Sacrifice', 'Reset your game with <b>1 million</b> cookies baked.<q>Easy come, easy go.</q>', [11, 6], 2);
			Achievement('Oblivion', 'Reset your game with <b>1 billion</b> cookies baked.<q>Back to square one.</q>', [11, 6], 2);
			Achievement('From scratch', 'Reset your game with <b>1 trillion</b> cookies baked.<q>It\'s been fun.</q>', [11, 6], 2);

			order=31000;
			Achievement('Neverclick', 'Make <b>1 million</b> cookies by only having clicked <b>15 times</b>.', [12, 0], 2);
			order=1000;
			Achievement('Clicktastic', 'Make <b>1,000</b> cookies from clicking.', [11, 0]);
			Achievement('Clickathlon', 'Make <b>100,000</b> cookies from clicking.', [11, 1]);
			Achievement('Clickolympics', 'Make <b>10,000,000</b> cookies from clicking.', [11, 1]);
			Achievement('Clickorama', 'Make <b>1,000,000,000</b> cookies from clicking.', [11, 2]);

			order=1050;
			Achievement('Click', 'Have <b>1</b> cursor.', [0, 0]);
			Achievement('Double-click', 'Have <b>2</b> cursors.', [0, 6]);
			Achievement('Mouse wheel', 'Have <b>50</b> cursors.', [1, 6]);
			Achievement('Of Mice and Men', 'Have <b>100</b> cursors.', [2, 6]);
			Achievement('The Digital', 'Have <b>200</b> cursors.', [3, 6]);

			order=1100;
			Achievement('Just wrong', 'Sell a grandma.<q>I thought you loved me.</q>', [10, 9], 2);
			Achievement('Grandma\'s cookies', 'Have <b>1</b> grandma.', [1, 0]);
			Achievement('Sloppy kisses', 'Have <b>50</b> grandmas.', [1, 1]);
			Achievement('Retirement home', 'Have <b>100</b> grandmas.', [1, 2]);

			order=1200;
			Achievement('My first farm', 'Have <b>1</b> farm.', [2, 0]);
			Achievement('Reap what you sow', 'Have <b>50</b> farms.', [2, 1]);
			Achievement('Farm ill', 'Have <b>100</b> farms.', [2, 2]);

			order=1300;
			Achievement('Production chain', 'Have <b>1</b> factory.', [4, 0]);
			Achievement('Industrial revolution', 'Have <b>50</b> factories.', [4, 1]);
			Achievement('Global warming', 'Have <b>100</b> factories.', [4, 2]);

			order=1400;
			Achievement('You know the drill', 'Have <b>1</b> mine.', [3, 0]);
			Achievement('Excavation site', 'Have <b>50</b> mines.', [3, 1]);
			Achievement('Hollow the planet', 'Have <b>100</b> mines.', [3, 2]);

			order=1500;
			Achievement('Expedition', 'Have <b>1</b> shipment.', [5, 0]);
			Achievement('Galactic highway', 'Have <b>50</b> shipments.', [5, 1]);
			Achievement('Far far away', 'Have <b>100</b> shipments.', [5, 2]);

			order=1600;
			Achievement('Transmutation', 'Have <b>1</b> alchemy lab.', [6, 0]);
			Achievement('Transmogrification', 'Have <b>50</b> alchemy labs.', [6, 1]);
			Achievement('Gold member', 'Have <b>100</b> alchemy labs.', [6, 2]);

			order=1700;
			Achievement('A whole world', 'Have <b>1</b> portal.', [7, 0]);
			Achievement('Now you\'re thinking', 'Have <b>50</b> portals.', [7, 1]);
			Achievement('Dimensional shift', 'Have <b>100</b> portals.', [7, 2]);

			order=1800;
			Achievement('Time warp', 'Have <b>1</b> time machine.', [8, 0]);
			Achievement('Alternate timeline', 'Have <b>50</b> time machines.', [8, 1]);
			Achievement('Rewriting history', 'Have <b>100</b> time machines.', [8, 2]);

			order=7000;
			Achievement('One with everything', 'Have <b>at least 1</b> of every building.', [4, 6], 2);
			Achievement('Mathematician', 'Have at least <b>1 of the most expensive object, 2 of the second-most expensive, 4 of the next</b> and so on (capped at 128).', [7, 6], 2);
			Achievement('Base 10', 'Have at least <b>10 of the most expensive object, 20 of the second-most expensive, 30 of the next</b> and so on.', [8, 6], 2);

			order=10000;
			Achievement('Golden cookie', 'Click a <b>golden cookie</b>.', [10, 1], 1);
			Achievement('Lucky cookie', 'Click <b>7 golden cookies</b>.', [10, 1], 1);
			Achievement('A stroke of luck', 'Click <b>27 golden cookies</b>.', [10, 1], 1);

			order=30200;
			Achievement('Cheated cookies taste awful', 'Hack in some cookies.', [10, 6], 3);
			order=30001;
			Achievement('Uncanny clicker', 'Click really, really fast.<q>Well I\'ll be!</q>', [12, 0], 2);

			order=5000;
			Achievement('Builder', 'Own <b>100</b> buildings.', [4, 6], 1);
			Achievement('Architect', 'Own <b>400</b> buildings.', [5, 6], 1);
			order=6000;
			Achievement('Enhancer', 'Purchase <b>20</b> upgrades.', [9, 0], 1);
			Achievement('Augmenter', 'Purchase <b>50</b> upgrades.', [9, 1], 1);

			order=11000;
			Achievement('Cookie-dunker', 'Dunk the cookie.<q>You did it!</q>', [4, 7], 2);

			order=10000;
			Achievement('Fortune', 'Click <b>77 golden cookies</b>.<q>You should really go to bed.</q>', [10, 1], 1);
			order=31000;
			Achievement('True Neverclick', 'Make <b>1 million</b> cookies with <b>no</b> cookie clicks.<q>This kinda defeats the whole purpose, doesn\'t it?</q>', [12, 0], 3);

			order=20000;
			Achievement('Elder nap', 'Appease the grandmatriarchs at least <b>once</b>.<q>we<br>are<br>eternal</q>', [8, 9], 2);
			Achievement('Elder slumber', 'Appease the grandmatriarchs at least <b>5 times</b>.<q>our mind<br>outlives<br>the universe</q>', [8, 9], 2);

			order=1150;
			Achievement('Elder', 'Own at least <b>7</b> grandma types.', [10, 9], 2);

			order=20000;
			Achievement('Elder calm', 'Declare a covenant with the grandmatriarchs.<q>we<br>have<br>fed</q>', [8, 9], 2);

			order=5000;
			Achievement('Engineer', 'Own <b>800</b> buildings.', [6, 6], 1);

			order=10000;
			Achievement('Leprechaun', 'Click <b>777 golden cookies</b>.', [10, 1], 1);
			Achievement('Black cat\'s paw', 'Click <b>7777 golden cookies</b>.', [10, 1], 3);

			order=30000;
			Achievement('Nihilism', 'Reset your game with <b>1 quadrillion</b> cookies baked.<q>There are many things<br>that need to be erased</q>', [11, 6], 2);
			//Achievement('Galactus\' Reprimand','Reset your game with <b>1 quintillion</b> coo- okay no I'm yanking your chain

			order=1900;
			Achievement('Antibatter', 'Have <b>1</b> antimatter condenser.', [13, 0]);
			Achievement('Quirky quarks', 'Have <b>50</b> antimatter condensers.', [13, 1]);
			Achievement('It does matter!', 'Have <b>100</b> antimatter condensers.', [13, 2]);

			order=6000;
			Achievement('Upgrader', 'Purchase <b>100</b> upgrades.', [9, 2], 1);

			order=7000;
			Achievement('Centennial', 'Have at least <b>100 of everything</b>.', [9, 6], 2);

			order=30500;
			Achievement('Hardcore', 'Get to <b>1 billion</b> cookies baked with <b>no upgrades purchased</b>.', [12, 6], 3);

			order=30600;
			Achievement('Speed baking I', 'Get to <b>1 million</b> cookies baked in <b>35 minutes</b> (with no heavenly upgrades).', [12, 5], 3);
			Achievement('Speed baking II', 'Get to <b>1 million</b> cookies baked in <b>25 minutes</b> (with no heavenly upgrades).', [13, 5], 3);
			Achievement('Speed baking III', 'Get to <b>1 million</b> cookies baked in <b>15 minutes</b> (with no heavenly upgrades).', [14, 5], 3);



			order=61000;
//			var achiev=Achievement('Getting even with the oven', 'Defeat the <b>Sentient Furnace</b> in the factory dungeons.', [12, 7], 3);
//			achiev.category='dungeon'; //make this 2 when dungeons are released
//			var achiev=Achievement('Now this is pod-smashing', 'Defeat the <b>Ascended Baking Pod</b> in the factory dungeons.', [12, 7], 3);
//			achiev.category='dungeon'; //make this 2 when dungeons are released
//			var achiev=Achievement('Chirped out', 'Find and defeat <b>Chirpy</b>, the dysfunctionning alarm bot.', [13, 7], 3);
//			achiev.category='dungeon';
//			var achiev=Achievement('Follow the white rabbit', 'Find and defeat the elusive <b>sugar bunny</b>.', [14, 7], 3);
//			achiev.category='dungeon';

			order=1000;
			Achievement('Clickasmic', 'Make <b>100,000,000,000</b> cookies from clicking.', [11, 13]);

			order=1100;
			Achievement('Friend of the ancients', 'Have <b>150</b> grandmas.', [1, 13]);
			Achievement('Ruler of the ancients', 'Have <b>200</b> grandmas.', [1, 13]);

			order=32000;
			Achievement('Wholesome', 'Unlock <b>100%</b> of your heavenly chips power.', [15, 7], 2);

			order=33000;
			Achievement('Just plain lucky', 'You have <b>1 chance in 500,000</b> every second of earning this achievement.', [15, 6], 3);

			order=21000;
			Achievement('Itchscratcher', 'Burst <b>1 wrinkler</b>.', [19, 8], 2);
			Achievement('Wrinklesquisher', 'Burst <b>50 wrinklers</b>.', [19, 8], 2);
			Achievement('Moistburster', 'Burst <b>200 wrinklers</b>.', [19, 8], 2);

			order=22000;
			Achievement('Spooky cookies', 'Unlock <b>every Halloween-themed cookie</b>.<br>Owning this achievement makes Halloween-themed cookies drop more frequently in future playthroughs.', [12, 8], 2);

			order=22100;
			Achievement('Coming to town', 'Reach <b>Santa\'s 7th form</b>.', [18, 9], 2);
			Achievement('All hail Santa', 'Reach <b>Santa\'s final form</b>.', [19, 10], 2);
			Achievement('Let it snow', 'Unlock <b>every Christmas-themed cookie</b>.', [19, 9], 2);
			Achievement('Oh deer', 'Pop <b>1 reindeer</b>.', [12, 9], 2);
			Achievement('Sleigh of hand', 'Pop <b>50 reindeer</b>.', [12, 9], 2);
			Achievement('Reindeer sleigher', 'Pop <b>200 reindeer</b>.', [12, 9], 2);

			order=1200;
			Achievement('Perfected agriculture', 'Have <b>150</b> farms.', [2, 13]);
			order=1300;
			Achievement('Ultimate automation', 'Have <b>150</b> factories.', [4, 13]);
			order=1400;
			Achievement('Can you dig it', 'Have <b>150</b> mines.', [3, 13]);
			order=1500;
			Achievement('Type II civilization', 'Have <b>150</b> shipments.', [5, 13]);
			order=1600;
			Achievement('Gild wars', 'Have <b>150</b> alchemy labs.', [6, 13]);
			order=1700;
			Achievement('Brain-split', 'Have <b>150</b> portals.', [7, 13]);
			order=1800;
			Achievement('Time duke', 'Have <b>150</b> time machines.', [8, 13]);
			order=1900;
			Achievement('Molecular maestro', 'Have <b>150</b> antimatter condensers.', [13, 13]);

			order=2000;
			Achievement('Lone photon', 'Have <b>1</b> prism.', [14, 0]);
			Achievement('Dazzling glimmer', 'Have <b>50</b> prisms.', [14, 1]);
			Achievement('Blinding flash', 'Have <b>100</b> prisms.', [14, 2]);
			Achievement('Unending glow', 'Have <b>150</b> prisms.', [14, 13]);

			order=5000;
			Achievement('Lord of Constructs', 'Own <b>1500</b> buildings.<q>He saw the vast plains stretching ahead of him, and he said : let there be civilization.</q>', [6, 6], 2);
			order=6000;
			Achievement('Lord of Progress', 'Purchase <b>150</b> upgrades.<q>One can always do better. But should you?</q>', [9, 2], 2);
			order=7000;
			Achievement('Bicentennial', 'Have at least <b>200 of everything</b>.<q>You crazy person.</q>', [9, 6], 2);

			order=22300;
			Achievement('Lovely cookies', 'Unlock <b>every Valentine-themed cookie</b>.', [20, 3], 2);


			return csvContext;
		}
	}
}
