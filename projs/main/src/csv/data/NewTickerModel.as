package csv.data
{



	public class NewTickerModel
	{
		public function NewTickerModel()
		{
		}

		public function setup():String
		{
			var keys:Array=['id', 'name', 'type', 'cookieEarned', 'tierObject', 'tierObjectAmount', 'tierAchievment', 'tierUpgrade', 'context'];
			var types:Array=['int', 'String', 'int', 'Number', 'String', 'int', 'String', 'String', 'String'];
			result=result + keys.join(',') + '\n';
			result=result + types.join(',') + '\n';
			getNewTicker();
			return result;
		}

		private var result:String='';
		private var tickId:int=1;

		private function listPush(obj:Object):void
		{
			// TODO Auto Generated method stub

			var temp:Array=[];
			temp.push(tickId);
			temp.push('News' + tickId);
			temp.push(type);
			temp.push(cookiesEarned);
			temp.push(tierObject);
			temp.push(tierObjectAmount);
			temp.push(tierAchievment);
			temp.push(tierUpgrade);
			if (obj is Array)
			{
				temp.push(TextData.formatAndPush('News' + tickId + '_Context_' + 0, obj[0]));
				result=result + temp.join(',') + '\n';
				var len:int=obj.length;
				for (var i:int=1; i < len; i++)
				{
					var temp2:Array=[];
					temp2.length=temp.length;
					temp2[temp2.length - 1]=TextData.formatAndPush('News' + tickId + '_Context_' + i, obj[i]);
					result=result + temp2.join(',') + '\n';
				}
			}
			else
			{
				temp.push(TextData.formatAndPush('News' + tickId + '_Context', obj as String));
				result=result + temp.join(',') + '\n';
			}


			tickId++;
		}

		private var type:int=1;
		private var cookiesEarned:Number=0;
		private var tierObject:String='';
		private var tierObjectAmount:int=0;
		private var tierAchievment:String='';
		private var tierUpgrade:String='';


		public function getNewTicker():void
		{
			tierObject='Grandma';
			tierObjectAmount=(0)
			listPush(myChoose(['<q>Moist cookies.</q><sig>grandma</sig>', '<q>We\'re nice grandmas.</q><sig>grandma</sig>', '<q>Indentured servitude.</q><sig>grandma</sig>', '<q>Come give grandma a kiss.</q><sig>grandma</sig>', '<q>Why don\'t you visit more often?</q><sig>grandma</sig>', '<q>Call me...</q><sig>grandma</sig>']));

			tierObject='Grandma';
			tierObjectAmount=(50)
			listPush(myChoose(['<q>Absolutely disgusting.</q><sig>grandma</sig>', '<q>You make me sick.</q><sig>grandma</sig>', '<q>You disgust me.</q><sig>grandma</sig>', '<q>We rise.</q><sig>grandma</sig>', '<q>It begins.</q><sig>grandma</sig>', '<q>It\'ll all be over soon.</q><sig>grandma</sig>', '<q>You could have stopped it.</q><sig>grandma</sig>']));

			tierObject='Farm';
			tierObjectAmount=(0)
			listPush(myChoose(['News : cookie farms suspected of employing undeclared elderly workforce!', 'News : cookie farms release harmful chocolate in our rivers, says scientist!', 'News : genetically-modified chocolate controversy strikes cookie farmers!', 'News : free-range farm cookies popular with today\'s hip youth, says specialist.', 'News : farm cookies deemed unfit for vegans, says nutritionist.']));

			tierObject='Factory';
			tierObjectAmount=(0)
			listPush(myChoose(['News : cookie factories linked to global warming!', 'News : cookie factories involved in chocolate weather controversy!', 'News : cookie factories on strike, robotic minions employed to replace workforce!', 'News : cookie factories on strike - workers demand to stop being paid in cookies!', 'News : factory-made cookies linked to obesity, says study.']));

			tierObject='Mine';
			tierObjectAmount=(0)
			listPush(myChoose(['News : ' + Math.floor(Math.random() * 1000 + 2) + ' miners dead in chocolate mine catastrophe!', 'News : ' + Math.floor(Math.random() * 1000 + 2) + ' miners trapped in collapsed chocolate mine!', 'News : chocolate mines found to cause earthquakes and sink holes!', 'News : chocolate mine goes awry, floods village in chocolate!', 'News : depths of chocolate mines found to house "peculiar, chocolaty beings"!']));

			tierObject='Shipment';
			tierObjectAmount=(0)
			listPush(myChoose(['News : new chocolate planet found, becomes target of cookie-trading spaceships!', 'News : massive chocolate planet found with 99.8% certified pure dark chocolate core!', 'News : space tourism booming as distant planets attract more bored millionaires!', 'News : chocolate-based organisms found on distant planet!', 'News : ancient baking artifacts found on distant planet; "terrifying implications", experts say.']));

			tierObject='Alchemy lab';
			tierObjectAmount=(0)
			listPush(myChoose(['News : national gold reserves dwindle as more and more of the precious mineral is turned to cookies!', 'News : chocolate jewelry found fashionable, gold and diamonds "just a fad", says specialist.', 'News : silver found to also be transmutable into white chocolate!', 'News : defective alchemy lab shut down, found to convert cookies to useless gold.', 'News : alchemy-made cookies shunned by purists!']));

			tierObject='Portal';
			tierObjectAmount=(0)
			listPush(myChoose(['News : nation worried as more and more unsettling creatures emerge from dimensional portals!', 'News : dimensional portals involved in city-engulfing disaster!', 'News : tourism to cookieverse popular with bored teenagers! Casualty rate as high as 73%!', 'News : cookieverse portals suspected to cause fast aging and obsession with baking, says study.', 'News : "do not settle near portals," says specialist; "your children will become strange and corrupted inside."']));

			tierObject='Time machine';
			tierObjectAmount=(0)
			listPush(myChoose(['News : time machines involved in history-rewriting scandal! Or are they?', 'News : time machines used in unlawful time tourism!', 'News : cookies brought back from the past "unfit for human consumption", says historian.', 'News : various historical figures inexplicably replaced with talking lumps of dough!', 'News : "I have seen the future," says time machine operator, "and I do not wish to go there again."']));

			tierObject='Antimatter condenser';
			tierObjectAmount=(0)
			listPush(myChoose(['News : whole town seemingly swallowed by antimatter-induced black hole; more reliable sources affirm town "never really existed"!', 'News : "explain to me again why we need particle accelerators to bake cookies?" asks misguided local woman.', 'News : first antimatter condenser successfully turned on, doesn\'t rip apart reality!', 'News : researchers conclude that what the cookie industry needs, first and foremost, is "more magnets".', 'News : "unravelling the fabric of reality just makes these cookies so much tastier", claims scientist.']));

			tierObject='Prism';
			tierObjectAmount=(0)
			listPush(myChoose(['News : new cookie-producing prisms linked to outbreak of rainbow-related viral videos.', 'News : scientists warn against systematically turning light into matter - "One day, we\'ll end up with all matter and no light!"', 'News : cookies now being baked at the literal speed of light thanks to new prismatic contraptions.', 'News : "Can\'t you sense the prism watching us?", rambles insane local man. "No idea what he\'s talking about", shrugs cookie magnate/government official.', 'News : world citizens advised "not to worry" about frequent atmospheric flashes.',]));

			tierObject='';
			tierObjectAmount=0;

			tierAchievment=(('Just wrong'))
			listPush(myChoose(['News : cookie manufacturer downsizes, sells own grandmother!', '<q>It has betrayed us, the filthy little thing.</q><sig>grandma</sig>', '<q>It tried to get rid of us, the nasty little thing.</q><sig>grandma</sig>', '<q>It thought we would go away by selling us. How quaint.</q><sig>grandma</sig>', '<q>I can smell your rotten cookies.</q><sig>grandma</sig>']));
			tierAchievment=(('Base 10'))
			listPush('News : cookie manufacturer completely forgoes common sense, lets OCD drive building decisions!'); //somehow I got flak for this one
			tierAchievment=(('From scratch'))
			listPush('News : follow the tear-jerking, riches-to-rags story about a local cookie manufacturer who decided to give it all up!');
			tierAchievment=(('A world filled with cookies'))
			listPush('News : known universe now jammed with cookies! No vacancies!');


			tierAchievment='';
			tierUpgrade=(('Serendipity'))
			listPush('News : local cookie manufacturer becomes luckiest being alive!');
			tierUpgrade=(('Kitten helpers'))
			listPush('News : faint meowing heard around local cookie facilities; suggests new ingredient being tested.');
			tierUpgrade=(('Kitten workers'))
			listPush('News : crowds of meowing kittens with little hard hats reported near local cookie facilities.');
			tierUpgrade=(('Kitten engineers'))
			listPush('News : surroundings of local cookie facilities now overrun with kittens in adorable little suits. Authorities advise to stay away from the premises.');
			tierUpgrade=(('Kitten overseers'))
			listPush('News : locals report troupe of bossy kittens meowing adorable orders at passersby.');

			tierUpgrade='';
			type=2;
			(cookiesEarned=5)
			listPush('You feel like making cookies. But nobody wants to eat your cookies.');
			(cookiesEarned=50)
			listPush('Your first batch goes to the trash. The neighborhood raccoon barely touches it.');
			(cookiesEarned=100)
			listPush('Your family accepts to try some of your cookies.');
			(cookiesEarned=500)
			listPush('Your cookies are popular in the neighborhood.');
			(cookiesEarned=1000)
			listPush('People are starting to talk about your cookies.');
			(cookiesEarned=3000)
			listPush('Your cookies are talked about for miles around.');
			(cookiesEarned=6000)
			listPush('Your cookies are renowned in the whole town!');
			(cookiesEarned=10000)
			listPush('Your cookies bring all the boys to the yard.');
			(cookiesEarned=20000)
			listPush('Your cookies now have their own website!');
			(cookiesEarned=30000)
			listPush('Your cookies are worth a lot of money.');
			(cookiesEarned=40000)
			listPush('Your cookies sell very well in distant countries.');
			(cookiesEarned=60000)
			listPush('People come from very far away to get a taste of your cookies.');
			(cookiesEarned=80000)
			listPush('Kings and queens from all over the world are enjoying your cookies.');
			(cookiesEarned=100000)
			listPush('There are now museums dedicated to your cookies.');
			(cookiesEarned=200000)
			listPush('A national day has been created in honor of your cookies.');
			(cookiesEarned=300000)
			listPush('Your cookies have been named a part of the world wonders.');
			(cookiesEarned=450000)
			listPush('History books now include a whole chapter about your cookies.');
			(cookiesEarned=600000)
			listPush('Your cookies have been placed under government surveillance.');
			(cookiesEarned=1000000)
			listPush('The whole planet is enjoying your cookies!');
			(cookiesEarned=5000000)
			listPush('Strange creatures from neighboring planets wish to try your cookies.');
			(cookiesEarned=10000000)
			listPush('Elder gods from the whole cosmos have awoken to taste your cookies.');
			(cookiesEarned=30000000)
			listPush('Beings from other dimensions lapse into existence just to get a taste of your cookies.');
			(cookiesEarned=100000000)
			listPush('Your cookies have achieved sentience.');
			(cookiesEarned=300000000)
			listPush('The universe has now turned into cookie dough, to the molecular level.');
			(cookiesEarned=1000000000)
			listPush('Your cookies are rewriting the fundamental laws of the universe.');
			(cookiesEarned=10000000000)
			listPush('A local news station runs a 10-minute segment about your cookies. Success!<br><span style="font-size:50%;">(you win a cookie)</span>');
			(cookiesEarned=10100000000)
			listPush('it\'s time to stop playing'); //only show this for 100 millions (it's funny for a moment)
		}

		private function myChoose(param0:Array):Object
		{
			// TODO Auto Generated method stub
			return param0;
		}
	}
}
