package agame.endless.modules.main.model.objects
{
	import com.agame.services.csv.CSVFile;
	import com.agame.utils.choose;

	import flash.utils.ByteArray;

	import agame.endless.modules.main.model.Game;
	import agame.endless.services.assets.Assets;

	public class ObjectDataModel
	{
		public function ObjectDataModel()
		{
		}

		public static function setup():void
		{
			ObjectData.csvFile=new CSVFile;
			var ba:ByteArray=Assets.current.getByteArray('objects');
			ObjectData.csvFile.read(ba.readUTFBytes(ba.bytesAvailable)).parse();

			//define objects
			new ObjectData(function():Number
			{
				var add:Number=0;
				if (Game.Has('Thousand fingers'))
					add+=0.1;
				if (Game.Has('Million fingers'))
					add+=0.5;
				if (Game.Has('Billion fingers'))
					add+=2;
				if (Game.Has('Trillion fingers'))
					add+=10;
				if (Game.Has('Quadrillion fingers'))
					add+=20;
				if (Game.Has('Quintillion fingers'))
					add+=100;
				if (Game.Has('Sextillion fingers'))
					add+=200;
				var num:Number=0;
				for (var i:String in Game.Objects)
				{
					if (Game.Objects[i].name != 'Cursor')
						num+=Game.Objects[i].amount;
				}
				add=add * num;
				return Game.ComputeCps(0.1, Game.Has('Reinforced index finger') * 0.1, Game.Has('Carpal tunnel prevention cream') + Game.Has('Ambidextrous'), add);
			}, {}, function():void
			{
				if (this.amount >= 1)
					Game.Unlock(['Reinforced index finger', 'Carpal tunnel prevention cream']);
				if (this.amount >= 10)
					Game.Unlock('Ambidextrous');
				if (this.amount >= 20)
					Game.Unlock('Thousand fingers');
				if (this.amount >= 40)
					Game.Unlock('Million fingers');
				if (this.amount >= 80)
					Game.Unlock('Billion fingers');
				if (this.amount >= 120)
					Game.Unlock('Trillion fingers');
				if (this.amount >= 160)
					Game.Unlock('Quadrillion fingers');
				if (this.amount >= 200)
					Game.Unlock('Quintillion fingers');
				if (this.amount >= 240)
					Game.Unlock('Sextillion fingers');

				if (this.amount >= 1)
					Game.Win('Click');
				if (this.amount >= 2)
					Game.Win('Double-click');
				if (this.amount >= 50)
					Game.Win('Mouse wheel');
				if (this.amount >= 100)
					Game.Win('Of Mice and Men');
				if (this.amount >= 200)
					Game.Win('The Digital');
			});

			Game.SpecialGrandmaUnlock=15;
			new ObjectData(function():Number
			{
				var mult:Number=0;
				if (Game.Has('Farmer grandmas'))
					mult++;
				if (Game.Has('Worker grandmas'))
					mult++;
				if (Game.Has('Miner grandmas'))
					mult++;
				if (Game.Has('Cosmic grandmas'))
					mult++;
				if (Game.Has('Transmuted grandmas'))
					mult++;
				if (Game.Has('Altered grandmas'))
					mult++;
				if (Game.Has('Grandmas\' grandmas'))
					mult++;
				if (Game.Has('Antigrandmas'))
					mult++;
				if (Game.Has('Rainbow grandmas'))
					mult++;
				if (Game.Has('Bingo center/Research facility'))
					mult+=2;
				if (Game.Has('Ritual rolling pins'))
					mult++;
				if (Game.Has('Naughty list'))
					mult++;
				var add:Number=0;
				if (Game.Has('One mind'))
					add+=Game.Objects['Grandma'].amount * 0.02;
				if (Game.Has('Communal brainsweep'))
					add+=Game.Objects['Grandma'].amount * 0.02;
				if (Game.Has('Elder Pact'))
					add+=Game.Objects['Portal'].amount * 0.05;
				return Game.ComputeCps(0.5, Game.Has('Forwards from grandma') * 0.3 + add, Game.Has('Steel-plated rolling pins') + Game.Has('Lubricated dentures') + Game.Has('Prune juice') + Game.Has('Double-thick glasses') + mult);
			}, Game.NewDrawFunction(chooseGradma(), 0, 0, 32, 3, 0), function():void
			{
				if (this.amount >= 1)
					Game.Unlock(['Forwards from grandma', 'Steel-plated rolling pins']);
				if (this.amount >= 10)
					Game.Unlock('Lubricated dentures');
				if (this.amount >= 50)
					Game.Unlock('Prune juice');
				if (this.amount >= 100)
					Game.Unlock('Double-thick glasses');
				if (this.amount >= 1)
					Game.Win('Grandma\'s cookies');
				if (this.amount >= 50)
					Game.Win('Sloppy kisses');
				if (this.amount >= 100)
					Game.Win('Retirement home');
				if (this.amount >= 150)
					Game.Win('Friend of the ancients');
				if (this.amount >= 200)
					Game.Win('Ruler of the ancients');
			});
			Game.Objects['Grandma'].sellFunction=function():void
			{
				Game.Win('Just wrong');
				if (this.amount == 0)
				{
//					Game.Lock('Elder Pledge');
//					Game.CollectWrinklers();
//					Game.pledgeT=0;
				}
			};

			new ObjectData(function():Number
			{
				return Game.ComputeCps(4, Game.Has('Cheap hoes') * 1, Game.Has('Fertilizer') + Game.Has('Cookie trees') + Game.Has('Genetically-modified cookies') + Game.Has('Gingerbread scarecrows'));
			}, Game.NewDrawFunction('', 16, 16, 64, 2, 32), function():void
			{
				if (this.amount >= 1)
					Game.Unlock(['Cheap hoes', 'Fertilizer']);
				if (this.amount >= 10)
					Game.Unlock('Cookie trees');
				if (this.amount >= 50)
					Game.Unlock('Genetically-modified cookies');
				if (this.amount >= 100)
					Game.Unlock('Gingerbread scarecrows');
				if (this.amount >= Game.SpecialGrandmaUnlock && Game.Objects['Grandma'].amount > 0)
					Game.Unlock('Farmer grandmas');
				if (this.amount >= 1)
					Game.Win('My first farm');
				if (this.amount >= 50)
					Game.Win('Reap what you sow');
				if (this.amount >= 100)
					Game.Win('Farm ill');
				if (this.amount >= 150)
					Game.Win('Perfected agriculture');
			});

			new ObjectData(function():Number
			{
				return Game.ComputeCps(10, Game.Has('Sturdier conveyor belts') * 4, Game.Has('Child labor') + Game.Has('Sweatshop') + Game.Has('Radium reactors') + Game.Has('Recombobulators'));
			}, Game.NewDrawFunction('', 32, 2, 64, 1, -22), function():void
			{
				if (this.amount >= 1)
					Game.Unlock(['Sturdier conveyor belts', 'Child labor']);
				if (this.amount >= 10)
					Game.Unlock('Sweatshop');
				if (this.amount >= 50)
					Game.Unlock('Radium reactors');
				if (this.amount >= 100)
					Game.Unlock('Recombobulators');
				if (this.amount >= Game.SpecialGrandmaUnlock && Game.Objects['Grandma'].amount > 0)
					Game.Unlock('Worker grandmas');
				if (this.amount >= 1)
					Game.Win('Production chain');
				if (this.amount >= 50)
					Game.Win('Industrial revolution');
				if (this.amount >= 100)
					Game.Win('Global warming');
				if (this.amount >= 150)
					Game.Win('Ultimate automation');
			});

			new ObjectData(function():Number
			{
				return Game.ComputeCps(40, Game.Has('Sugar gas') * 10, Game.Has('Megadrill') + Game.Has('Ultradrill') + Game.Has('Ultimadrill') + Game.Has('H-bomb mining'));
			}, Game.NewDrawFunction('', 16, 16, 64, 2, 24), function():void
			{
				if (this.amount >= 1)
					Game.Unlock(['Sugar gas', 'Megadrill']);
				if (this.amount >= 10)
					Game.Unlock('Ultradrill');
				if (this.amount >= 50)
					Game.Unlock('Ultimadrill');
				if (this.amount >= 100)
					Game.Unlock('H-bomb mining');
				if (this.amount >= Game.SpecialGrandmaUnlock && Game.Objects['Grandma'].amount > 0)
					Game.Unlock('Miner grandmas');
				if (this.amount >= 1)
					Game.Win('You know the drill');
				if (this.amount >= 50)
					Game.Win('Excavation site');
				if (this.amount >= 100)
					Game.Win('Hollow the planet');
				if (this.amount >= 150)
					Game.Win('Can you dig it');
			});

			new ObjectData(function():Number
			{
				return Game.ComputeCps(100, Game.Has('Vanilla nebulae') * 30, Game.Has('Wormholes') + Game.Has('Frequent flyer') + Game.Has('Warp drive') + Game.Has('Chocolate monoliths'));
			}, Game.NewDrawFunction('', 16, 16, 64), function():void
			{
				if (this.amount >= 1)
					Game.Unlock(['Vanilla nebulae', 'Wormholes']);
				if (this.amount >= 10)
					Game.Unlock('Frequent flyer');
				if (this.amount >= 50)
					Game.Unlock('Warp drive');
				if (this.amount >= 100)
					Game.Unlock('Chocolate monoliths');
				if (this.amount >= Game.SpecialGrandmaUnlock && Game.Objects['Grandma'].amount > 0)
					Game.Unlock('Cosmic grandmas');
				if (this.amount >= 1)
					Game.Win('Expedition');
				if (this.amount >= 50)
					Game.Win('Galactic highway');
				if (this.amount >= 100)
					Game.Win('Far far away');
				if (this.amount >= 150)
					Game.Win('Type II civilization');
			});

			new ObjectData(function():Number
			{
				return Game.ComputeCps(400, Game.Has('Antimony') * 100, Game.Has('Essence of dough') + Game.Has('True chocolate') + Game.Has('Ambrosia') + Game.Has('Aqua crustulae'));
			}, Game.NewDrawFunction(0, 16, 16, 64, 2, 16), function():void
			{
				if (this.amount >= 1)
					Game.Unlock(['Antimony', 'Essence of dough']);
				if (this.amount >= 10)
					Game.Unlock('True chocolate');
				if (this.amount >= 50)
					Game.Unlock('Ambrosia');
				if (this.amount >= 100)
					Game.Unlock('Aqua crustulae');
				if (this.amount >= Game.SpecialGrandmaUnlock && Game.Objects['Grandma'].amount > 0)
					Game.Unlock('Transmuted grandmas');
				if (this.amount >= 1)
					Game.Win('Transmutation');
				if (this.amount >= 50)
					Game.Win('Transmogrification');
				if (this.amount >= 100)
					Game.Win('Gold member');
				if (this.amount >= 150)
					Game.Win('Gild wars');
			});

			new ObjectData(function():Number
			{
				return Game.ComputeCps(6666, Game.Has('Ancient tablet') * 1666, Game.Has('Insane oatling workers') + Game.Has('Soul bond') + Game.Has('Sanity dance') + Game.Has('Brane transplant'));
			}, Game.NewDrawFunction(0, 32, 32, 64, 2), function():void
			{
				if (this.amount >= 1)
					Game.Unlock(['Ancient tablet', 'Insane oatling workers']);
				if (this.amount >= 10)
					Game.Unlock('Soul bond');
				if (this.amount >= 50)
					Game.Unlock('Sanity dance');
				if (this.amount >= 100)
					Game.Unlock('Brane transplant');
				if (this.amount >= Game.SpecialGrandmaUnlock && Game.Objects['Grandma'].amount > 0)
					Game.Unlock('Altered grandmas');
				if (this.amount >= 1)
					Game.Win('A whole new world');
				if (this.amount >= 50)
					Game.Win('Now you\'re thinking');
				if (this.amount >= 100)
					Game.Win('Dimensional shift');
				if (this.amount >= 150)
					Game.Win('Brain-split');
			});
			new ObjectData(function():Number
			{
				return Game.ComputeCps(98765, Game.Has('Flux capacitors') * 9876, Game.Has('Time paradox resolver') + Game.Has('Quantum conundrum') + Game.Has('Causality enforcer') + Game.Has('Yestermorrow comparators'));
			}, Game.NewDrawFunction(0, 32, 32, 64, 1), function():void
			{
				if (this.amount >= 1)
					Game.Unlock(['Flux capacitors', 'Time paradox resolver']);
				if (this.amount >= 10)
					Game.Unlock('Quantum conundrum');
				if (this.amount >= 50)
					Game.Unlock('Causality enforcer');
				if (this.amount >= 100)
					Game.Unlock('Yestermorrow comparators');
				if (this.amount >= Game.SpecialGrandmaUnlock && Game.Objects['Grandma'].amount > 0)
					Game.Unlock('Grandmas\' grandmas');
				if (this.amount >= 1)
					Game.Win('Time warp');
				if (this.amount >= 50)
					Game.Win('Alternate timeline');
				if (this.amount >= 100)
					Game.Win('Rewriting history');
				if (this.amount >= 150)
					Game.Win('Time duke');
			});
			new ObjectData(function():Number
			{
				return Game.ComputeCps(999999, Game.Has('Sugar bosons') * 99999, Game.Has('String theory') + Game.Has('Large macaron collider') + Game.Has('Big bang bake') + Game.Has('Reverse cyclotrons'));
			}, Game.NewDrawFunction(0, 0, 64, 64, 1), function():void
			{
				if (this.amount >= 1)
					Game.Unlock(['Sugar bosons', 'String theory']);
				if (this.amount >= 10)
					Game.Unlock('Large macaron collider');
				if (this.amount >= 50)
					Game.Unlock('Big bang bake');
				if (this.amount >= 100)
					Game.Unlock('Reverse cyclotrons');
				if (this.amount >= Game.SpecialGrandmaUnlock && Game.Objects['Grandma'].amount > 0)
					Game.Unlock('Antigrandmas');
				if (this.amount >= 1)
					Game.Win('Antibatter');
				if (this.amount >= 50)
					Game.Win('Quirky quarks');
				if (this.amount >= 100)
					Game.Win('It does matter!');
				if (this.amount >= 150)
					Game.Win('Molecular maestro');
			});
			new ObjectData(function():Number
			{
				return Game.ComputeCps(10000000, Game.Has('Gem polish') * 1000000, Game.Has('9th color') + Game.Has('Chocolate light') + Game.Has('Grainbow') + Game.Has('Pure cosmic light'));
			}, Game.NewDrawFunction(0, 16, 4, 64, 1, 20), function():void
			{
				if (this.amount >= 1)
					Game.Unlock(['Gem polish', '9th color']);
				if (this.amount >= 10)
					Game.Unlock('Chocolate light');
				if (this.amount >= 50)
					Game.Unlock('Grainbow');
				if (this.amount >= 100)
					Game.Unlock('Pure cosmic light');
				if (this.amount >= Game.SpecialGrandmaUnlock && Game.Objects['Grandma'].amount > 0)
					Game.Unlock('Rainbow grandmas');
				if (this.amount >= 1)
					Game.Win('Lone photon');
				if (this.amount >= 50)
					Game.Win('Dazzling glimmer');
				if (this.amount >= 100)
					Game.Win('Blinding flash');
				if (this.amount >= 150)
					Game.Win('Unending glow');
			});


			trace('setup object complete,total=' + ObjectData.ObjectDatasN);
		}

		public static function chooseGradma():String
		{
			var list:Array=['grandma'];
			if (Game.Has('Farmer grandmas'))
				list.push('farmerGrandma');
			if (Game.Has('Worker grandmas'))
				list.push('workerGrandma');
			if (Game.Has('Miner grandmas'))
				list.push('minerGrandma');
			if (Game.Has('Cosmic grandmas'))
				list.push('cosmicGrandma');
			if (Game.Has('Transmuted grandmas'))
				list.push('transmutedGrandma');
			if (Game.Has('Altered grandmas'))
				list.push('alteredGrandma');
			if (Game.Has('Grandmas\' grandmas'))
				list.push('grandmasGrandma');
			if (Game.Has('Antigrandmas'))
				list.push('antiGrandma');
			if (Game.Has('Rainbow grandmas'))
				list.push('rainbowGrandma');
			return choose(list);
		}
	}
}
