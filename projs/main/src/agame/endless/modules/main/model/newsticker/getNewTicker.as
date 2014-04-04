package agame.endless.modules.main.model.newsticker
{
	import com.agame.utils.choose;

	import agame.endless.modules.main.model.Game;
	import agame.endless.modules.main.model.MainModel;

	public function getNewTicker():void
	{
		var list:Array=[];

		if (Game.TickerN % 2 == 0 || Game.cookiesEarned >= 10100000000)
		{
			if (Game.Objects['Grandma'].amount > 0)
				list.push(choose(['<q>Moist cookies.</q><sig>grandma</sig>', '<q>We\'re nice grandmas.</q><sig>grandma</sig>', '<q>Indentured servitude.</q><sig>grandma</sig>', '<q>Come give grandma a kiss.</q><sig>grandma</sig>', '<q>Why don\'t you visit more often?</q><sig>grandma</sig>', '<q>Call me...</q><sig>grandma</sig>']));

			if (Game.Objects['Grandma'].amount >= 50)
				list.push(choose(['<q>Absolutely disgusting.</q><sig>grandma</sig>', '<q>You make me sick.</q><sig>grandma</sig>', '<q>You disgust me.</q><sig>grandma</sig>', '<q>We rise.</q><sig>grandma</sig>', '<q>It begins.</q><sig>grandma</sig>', '<q>It\'ll all be over soon.</q><sig>grandma</sig>', '<q>You could have stopped it.</q><sig>grandma</sig>']));

			if (Game.HasAchiev('Just wrong'))
				list.push(choose(['News : cookie manufacturer downsizes, sells own grandmother!', '<q>It has betrayed us, the filthy little thing.</q><sig>grandma</sig>', '<q>It tried to get rid of us, the nasty little thing.</q><sig>grandma</sig>', '<q>It thought we would go away by selling us. How quaint.</q><sig>grandma</sig>', '<q>I can smell your rotten cookies.</q><sig>grandma</sig>']));

			if (Game.Objects['Grandma'].amount >= 1 && Game.pledges > 0 && Game.elderWrath == 0)
				list.push(choose(['<q>shrivel</q><sig>grandma</sig>', '<q>writhe</q><sig>grandma</sig>', '<q>throb</q><sig>grandma</sig>', '<q>gnaw</q><sig>grandma</sig>', '<q>We will rise again.</q><sig>grandma</sig>', '<q>A mere setback.</q><sig>grandma</sig>', '<q>We are not satiated.</q><sig>grandma</sig>', '<q>Too late.</q><sig>grandma</sig>']));

			if (Game.Objects['Farm'].amount > 0)
				list.push(choose(['News : cookie farms suspected of employing undeclared elderly workforce!', 'News : cookie farms release harmful chocolate in our rivers, says scientist!', 'News : genetically-modified chocolate controversy strikes cookie farmers!', 'News : free-range farm cookies popular with today\'s hip youth, says specialist.', 'News : farm cookies deemed unfit for vegans, says nutritionist.']));

			if (Game.Objects['Factory'].amount > 0)
				list.push(choose(['News : cookie factories linked to global warming!', 'News : cookie factories involved in chocolate weather controversy!', 'News : cookie factories on strike, robotic minions employed to replace workforce!', 'News : cookie factories on strike - workers demand to stop being paid in cookies!', 'News : factory-made cookies linked to obesity, says study.']));

			if (Game.Objects['Mine'].amount > 0)
				list.push(choose(['News : ' + Math.floor(Math.random() * 1000 + 2) + ' miners dead in chocolate mine catastrophe!', 'News : ' + Math.floor(Math.random() * 1000 + 2) + ' miners trapped in collapsed chocolate mine!', 'News : chocolate mines found to cause earthquakes and sink holes!', 'News : chocolate mine goes awry, floods village in chocolate!', 'News : depths of chocolate mines found to house "peculiar, chocolaty beings"!']));

			if (Game.Objects['Shipment'].amount > 0)
				list.push(choose(['News : new chocolate planet found, becomes target of cookie-trading spaceships!', 'News : massive chocolate planet found with 99.8% certified pure dark chocolate core!', 'News : space tourism booming as distant planets attract more bored millionaires!', 'News : chocolate-based organisms found on distant planet!', 'News : ancient baking artifacts found on distant planet; "terrifying implications", experts say.']));

			if (Game.Objects['Alchemy lab'].amount > 0)
				list.push(choose(['News : national gold reserves dwindle as more and more of the precious mineral is turned to cookies!', 'News : chocolate jewelry found fashionable, gold and diamonds "just a fad", says specialist.', 'News : silver found to also be transmutable into white chocolate!', 'News : defective alchemy lab shut down, found to convert cookies to useless gold.', 'News : alchemy-made cookies shunned by purists!']));

			if (Game.Objects['Portal'].amount > 0)
				list.push(choose(['News : nation worried as more and more unsettling creatures emerge from dimensional portals!', 'News : dimensional portals involved in city-engulfing disaster!', 'News : tourism to cookieverse popular with bored teenagers! Casualty rate as high as 73%!', 'News : cookieverse portals suspected to cause fast aging and obsession with baking, says study.', 'News : "do not settle near portals," says specialist; "your children will become strange and corrupted inside."']));

			if (Game.Objects['Time machine'].amount > 0)
				list.push(choose(['News : time machines involved in history-rewriting scandal! Or are they?', 'News : time machines used in unlawful time tourism!', 'News : cookies brought back from the past "unfit for human consumption", says historian.', 'News : various historical figures inexplicably replaced with talking lumps of dough!', 'News : "I have seen the future," says time machine operator, "and I do not wish to go there again."']));

			if (Game.Objects['Antimatter condenser'].amount > 0)
				list.push(choose(['News : whole town seemingly swallowed by antimatter-induced black hole; more reliable sources affirm town "never really existed"!', 'News : "explain to me again why we need particle accelerators to bake cookies?" asks misguided local woman.', 'News : first antimatter condenser successfully turned on, doesn\'t rip apart reality!', 'News : researchers conclude that what the cookie industry needs, first and foremost, is "more magnets".', 'News : "unravelling the fabric of reality just makes these cookies so much tastier", claims scientist.']));

			if (Game.Objects['Prism'].amount > 0)
				list.push(choose(['News : new cookie-producing prisms linked to outbreak of rainbow-related viral videos.', 'News : scientists warn against systematically turning light into matter - "One day, we\'ll end up with all matter and no light!"', 'News : cookies now being baked at the literal speed of light thanks to new prismatic contraptions.', 'News : "Can\'t you sense the prism watching us?", rambles insane local man. "No idea what he\'s talking about", shrugs cookie magnate/government official.', 'News : world citizens advised "not to worry" about frequent atmospheric flashes.',]));

			if (Game.season == 'halloween' && Game.cookiesEarned >= 1000)
				list.push(choose(['News : strange twisting creatures amass around cookie factories, nibble at assembly lines.', 'News : ominous wrinkly monsters take massive bites out of cookie production; "this can\'t be hygienic", worries worker.', 'News : pagan rituals on the rise as children around the world dress up in strange costumes and blackmail homeowners for candy.', 'News : new-age terrorism strikes suburbs as houses find themselves covered in eggs and toilet paper.', 'News : children around the world "lost and confused" as any and all Halloween treats have been replaced by cookies.']));

			if (Game.season == 'christmas' && Game.cookiesEarned >= 1000)
				list.push(choose(['News : bearded maniac spotted speeding on flying sleigh! Investigation pending.', 'News : Santa Claus announces new brand of breakfast treats to compete with cookie-flavored cereals! "They\'re ho-ho-horrible!" says Santa.', 'News : "You mean he just gives stuff away for free?!", concerned moms ask. "Personally, I don\'t trust his beard."', 'News : obese jolly lunatic still on the loose, warn officials. "Keep your kids safe and board up your chimneys. We mean it."', 'News : children shocked as they discover Santa Claus isn\'t just their dad in a costume after all!<br>"I\'m reassessing my life right now", confides Laura, aged 6.', 'News : mysterious festive entity with quantum powers still wrecking havoc with army of reindeer, officials say.', 'News : elves on strike at toy factory! "We will not be accepting reindeer chow as payment anymore. And stop calling us elves!"', 'News : elves protest around the nation; wee little folks in silly little outfits spread mayhem, destruction; rabid reindeer running rampant through streets.', 'News : scholars debate regarding the plural of reindeer(s) in the midst of elven world war.', 'News : elves "unrelated to gnomes despite small stature and merry disposition", find scientists.', 'News : elves sabotage radioactive frosting factory, turn hundreds blind in vincinity - "Who in their right mind would do such a thing?" laments outraged mayor.', 'News : drama unfolds at North Pole as rumors crop up around Rudolph\'s red nose; "I may have an addiction or two", admits reindeer.']));

			if (Game.season == 'valentines' && Game.cookiesEarned >= 1000)
				list.push(choose(['News : organ-shaped confectioneries being traded in schools all over the world; gruesome practice undergoing investigation.', 'News : heart-shaped candies overtaking sweets business, offering competition to cookie empire. "It\'s the economy, cupid!"', 'News : love\'s in the air, according to weather specialists. Face masks now offered in every city to stunt airborne infection.', 'News : marrying a cookie - deranged practice, or glimpse of the future?', 'News : boyfriend dumped after offering his lover cookies for Valentine\'s Day, reports say. "They were off-brand", shrugs ex-girlfriend.']));

			if (Game.HasAchiev('Base 10'))
				list.push('News : cookie manufacturer completely forgoes common sense, lets OCD drive building decisions!'); //somehow I got flak for this one
			if (Game.HasAchiev('From scratch'))
				list.push('News : follow the tear-jerking, riches-to-rags story about a local cookie manufacturer who decided to give it all up!');
			if (Game.HasAchiev('A world filled with cookies'))
				list.push('News : known universe now jammed with cookies! No vacancies!');
			if (Game.Has('Serendipity'))
				list.push('News : local cookie manufacturer becomes luckiest being alive!');

			if (Game.Has('Kitten helpers'))
				list.push('News : faint meowing heard around local cookie facilities; suggests new ingredient being tested.');
			if (Game.Has('Kitten workers'))
				list.push('News : crowds of meowing kittens with little hard hats reported near local cookie facilities.');
			if (Game.Has('Kitten engineers'))
				list.push('News : surroundings of local cookie facilities now overrun with kittens in adorable little suits. Authorities advise to stay away from the premises.');
			if (Game.Has('Kitten overseers'))
				list.push('News : locals report troupe of bossy kittens meowing adorable orders at passersby.');

			var animals:Array=['newts', 'penguins', 'scorpions', 'axolotls', 'puffins', 'porpoises', 'blowfish', 'horses', 'crayfish', 'slugs', 'humpback whales', 'nurse sharks', 'giant squids', 'polar bears', 'fruit bats', 'frogs', 'sea squirts', 'velvet worms', 'mole rats', 'paramecia', 'nematodes', 'tardigrades', 'giraffes'];
			if (Game.cookiesEarned >= 10000)
				list.push('News : ' + choose(['cookies found to ' + choose(['increase lifespan', 'sensibly increase intelligence', 'reverse aging', 'decrease hair loss', 'prevent arthritis', 'cure blindness']) + ' in ' + choose(animals) + '!', 'cookies found to make ' + choose(animals) + ' ' + choose(['more docile', 'more handsome', 'nicer', 'less hungry', 'more pragmatic', 'tastier']) + '!', 'cookies tested on ' + choose(animals) + ', found to have no ill effects.', 'cookies unexpectedly popular among ' + choose(animals) + '!', 'unsightly lumps found on ' + choose(animals) + ' near cookie facility; "they\'ve pretty much always looked like that", say biologists.', 'new species of ' + choose(animals) + ' discovered in distant country; "yup, tastes like cookies", says biologist.', 'cookies go well with roasted ' + choose(animals) + ', says controversial chef.', '"do your cookies contain ' + choose(animals) + '?", asks PSA warning against counterfeit cookies.']), 'News : "' + choose(['I\'m all about cookies', 'I just can\'t stop eating cookies. I think I seriously need help', 'I guess I have a cookie problem', 'I\'m not addicted to cookies. That\'s just speculation by fans with too much free time', 'my upcoming album contains 3 songs about cookies', 'I\'ve had dreams about cookies 3 nights in a row now. I\'m a bit worried honestly', 'accusations of cookie abuse are only vile slander', 'cookies really helped me when I was feeling low', 'cookies are the secret behind my perfect skin', 'cookies helped me stay sane while filming my upcoming movie', 'cookies helped me stay thin and healthy', 'I\'ll say one word, just one : cookies', 'alright, I\'ll say it - I\'ve never eaten a single cookie in my life']) + '", reveals celebrity.', 'News : ' + choose(['doctors recommend twice-daily consumption of fresh cookies.', 'doctors warn against chocolate chip-snorting teen fad.', 'doctors advise against new cookie-free fad diet.', 'doctors warn mothers about the dangers of "home-made cookies".']), choose(['News : scientist predicts imminent cookie-related "end of the world"; becomes joke among peers.', 'News : man robs bank, buys cookies.', 'News : scientists establish that the deal with airline food is, in fact, a critical lack of cookies.', 'News : hundreds of tons of cookies dumped into starving country from airplanes; thousands dead, nation grateful.', 'News : new study suggests cookies neither speed up nor slow down aging, but instead "take you in a different direction".', 'News : overgrown cookies found in fishing nets, raise questions about hormone baking.', 'News : "all-you-can-eat" cookie restaurant opens in big city; waiters trampled in minutes.', 'News : man dies in cookie-eating contest; "a less-than-impressive performance", says judge.', 'News : what makes cookies taste so right? "Probably all the [*****] they put in them", says anonymous tipper.', 'News : man found allergic to cookies; "what a weirdo", says family.', 'News : foreign politician involved in cookie-smuggling scandal.', 'News : cookies now more popular than ' + choose(['cough drops', 'broccoli', 'smoked herring', 'cheese', 'video games', 'stable jobs', 'relationships', 'time travel', 'cat videos', 'tango', 'fashion', 'television', 'nuclear warfare', 'whatever it is we ate before', 'politics', 'oxygen', 'lamps']) + ', says study.', 'News : obesity epidemic strikes nation; experts blame ' + choose(['twerking', 'that darn rap music', 'video-games', 'lack of cookies', 'mysterious ghostly entities', 'aliens', 'parents', 'schools', 'comic-books', 'cookie-snorting fad']) + '.', 'News : cookie shortage strikes town, people forced to eat cupcakes; "just not the same", concedes mayor.', 'News : "you gotta admit, all this cookie stuff is a bit ominous", says confused idiot.', 'News : movie cancelled from lack of actors; "everybody\'s at home eating cookies", laments director.', 'News : comedian forced to cancel cookie routine due to unrelated indigestion.', 'News : new cookie-based religion sweeps the nation.', 'News : fossil records show cookie-based organisms prevalent during Cambrian explosion, scientists say.', 'News : mysterious illegal cookies seized; "tastes terrible", says police.', 'News : man found dead after ingesting cookie; investigators favor "mafia snitch" hypothesis.', 'News : "the universe pretty much loops on itself," suggests researcher; "it\'s cookies all the way down."', 'News : minor cookie-related incident turns whole town to ashes; neighboring cities asked to chip in for reconstruction.', 'News : is our media controlled by the cookie industry? This could very well be the case, says crackpot conspiracy theorist.', 'News : ' + choose(['cookie-flavored popcorn pretty damn popular; "we kinda expected that", say scientists.', 'cookie-flavored cereals break all known cereal-related records', 'cookies popular among all age groups, including fetuses, says study.', 'cookie-flavored popcorn sales exploded during screening of Grandmothers II : The Moistening.']), 'News : all-cookie restaurant opening downtown. Dishes such as braised cookies, cookie thermidor, and for dessert : crepes.', 'News : cookies could be the key to ' + choose(['eternal life', 'infinite riches', 'eternal youth', 'eternal beauty', 'curing baldness', 'world peace', 'solving world hunger', 'ending all wars world-wide', 'making contact with extraterrestrial life', 'mind-reading', 'better living', 'better eating', 'more interesting TV shows', 'faster-than-light travel', 'quantum baking', 'chocolaty goodness', 'gooder thoughtness']) + ', say scientists.', 'News : flavor text ' + choose(["not particularly flavorful", "kind of unsavory"]) + ', study finds.', 'News : what do golden cookies taste like? Study reveals a flavor "somewhere between spearmint and liquorice".', 'News : what do red cookies taste like? Study reveals a flavor "somewhere between blood sausage and seawater".']));
		}

		if (list.length == 0)
		{
			if (Game.cookiesEarned < 5)
				list.push('You feel like making cookies. But nobody wants to eat your cookies.');
			else if (Game.cookiesEarned < 50)
				list.push('Your first batch goes to the trash. The neighborhood raccoon barely touches it.');
			else if (Game.cookiesEarned < 100)
				list.push('Your family accepts to try some of your cookies.');
			else if (Game.cookiesEarned < 500)
				list.push('Your cookies are popular in the neighborhood.');
			else if (Game.cookiesEarned < 1000)
				list.push('People are starting to talk about your cookies.');
			else if (Game.cookiesEarned < 3000)
				list.push('Your cookies are talked about for miles around.');
			else if (Game.cookiesEarned < 6000)
				list.push('Your cookies are renowned in the whole town!');
			else if (Game.cookiesEarned < 10000)
				list.push('Your cookies bring all the boys to the yard.');
			else if (Game.cookiesEarned < 20000)
				list.push('Your cookies now have their own website!');
			else if (Game.cookiesEarned < 30000)
				list.push('Your cookies are worth a lot of money.');
			else if (Game.cookiesEarned < 40000)
				list.push('Your cookies sell very well in distant countries.');
			else if (Game.cookiesEarned < 60000)
				list.push('People come from very far away to get a taste of your cookies.');
			else if (Game.cookiesEarned < 80000)
				list.push('Kings and queens from all over the world are enjoying your cookies.');
			else if (Game.cookiesEarned < 100000)
				list.push('There are now museums dedicated to your cookies.');
			else if (Game.cookiesEarned < 200000)
				list.push('A national day has been created in honor of your cookies.');
			else if (Game.cookiesEarned < 300000)
				list.push('Your cookies have been named a part of the world wonders.');
			else if (Game.cookiesEarned < 450000)
				list.push('History books now include a whole chapter about your cookies.');
			else if (Game.cookiesEarned < 600000)
				list.push('Your cookies have been placed under government surveillance.');
			else if (Game.cookiesEarned < 1000000)
				list.push('The whole planet is enjoying your cookies!');
			else if (Game.cookiesEarned < 5000000)
				list.push('Strange creatures from neighboring planets wish to try your cookies.');
			else if (Game.cookiesEarned < 10000000)
				list.push('Elder gods from the whole cosmos have awoken to taste your cookies.');
			else if (Game.cookiesEarned < 30000000)
				list.push('Beings from other dimensions lapse into existence just to get a taste of your cookies.');
			else if (Game.cookiesEarned < 100000000)
				list.push('Your cookies have achieved sentience.');
			else if (Game.cookiesEarned < 300000000)
				list.push('The universe has now turned into cookie dough, to the molecular level.');
			else if (Game.cookiesEarned < 1000000000)
				list.push('Your cookies are rewriting the fundamental laws of the universe.');
			else if (Game.cookiesEarned < 10000000000)
				list.push('A local news station runs a 10-minute segment about your cookies. Success!<br><span style="font-size:50%;">(you win a cookie)</span>');
			else if (Game.cookiesEarned < 10100000000)
				list.push('it\'s time to stop playing'); //only show this for 100 millions (it's funny for a moment)
		}

		if (Game.elderWrath > 0 && (Game.pledges == 0 || Math.random() < 0.5))
		{
			list=[];
			if (Game.elderWrath == 1)
				list.push(choose(['News : millions of old ladies reported missing!', 'News : processions of old ladies sighted around cookie facilities!', 'News : families around the continent report agitated, transfixed grandmothers!', 'News : doctors swarmed by cases of old women with glassy eyes and a foamy mouth!', 'News : nurses report "strange scent of cookie dough" around female elderly patients!']));
			if (Game.elderWrath == 2)
				list.push(choose(['News : town in disarray as strange old ladies break into homes to abduct infants and baking utensils!', 'News : sightings of old ladies with glowing eyes terrify local population!', 'News : retirement homes report "female residents slowly congealing in their seats"!', 'News : whole continent undergoing mass exodus of old ladies!', 'News : old women freeze in place in streets, ooze warm sugary syrup!']));
			if (Game.elderWrath == 3)
				list.push(choose(['News : large "flesh highways" scar continent, stretch between various cookie facilities!', 'News : wrinkled "flesh tendrils" visible from space!', 'News : remains of "old ladies" found frozen in the middle of growing fleshy structures!', 'News : all hope lost as writhing mass of flesh and dough engulfs whole city!', 'News : nightmare continues as wrinkled acres of flesh expand at alarming speeds!']));
		}

		Game.TickerAge=Game.fps * 10;
		Game.Ticker=choose(list);
		Game.TickerN++;
		Game.dispatchEventWith(MainModel.NEWTICKER_CHANGED);
	}
}
