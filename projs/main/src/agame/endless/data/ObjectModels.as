package agame.endless.data
{

	public class ObjectModels
	{
		public function ObjectModels()
		{
		}

		public function setup():void
		{
			var id=1;
			var keys:Array=['ID', 'name', 'DisplayName', 'Single', 'Plural', 'ActionName', 'Desc', 'Price', 'Pic', 'Icon', 'Background'];
			var types:Array=['int', 'String', 'String', 'String', 'String', 'String', 'String', 'int', 'String', 'String', 'String'];
			trace(keys.join(','));
			trace(types.join(','));
			function Object(name, commonName, desc, pic, icon, background, price) //, cps=null, drawFunction=null, buyFunction=null)
			{
				var obj:*={};
				obj.id=id++;
				obj.name=name;
				obj.displayName=obj.name;
				commonName=commonName.split('|');
				obj.single=commonName[0];
				obj.plural=commonName[1];
				obj.actionName=commonName[2];
				obj.desc=desc;
				obj.basePrice=price;
				obj.price=obj.basePrice;
				obj.pic=pic;
				obj.icon=icon;
				obj.background=background;
				var temp:Array=[];
				temp.push(obj.id);
				temp.push(obj.name);
				temp.push(obj.displayName);
				temp.push(obj.single);
				temp.push(obj.plural);
				temp.push(obj.actionName);
				temp.push('"' + obj.desc + '"');
				temp.push(obj.price);
				temp.push(obj.pic);
				temp.push(obj.icon);
				temp.push(obj.background);
				trace(temp.join(','));
			}

			Object('Cursor', 'cursor|cursors|clicked', 'Autoclicks once every 10 seconds.', 'cursor', 'cursoricon', '', 15);
			Object('Grandma', 'grandma|grandmas|baked', 'A nice grandma to bake more cookies.', 'grandma', 'grandmaIcon', 'grandmaBackground', 100);
			Object('Farm', 'farm|farms|harvested', 'Grows cookie plants from cookie seeds.', 'farm', 'farmIcon', 'farmBackground', 500);
			Object('Factory', 'factory|factories|mass-produced', 'Produces large quantities of cookies.', 'factory', 'factoryIcon', 'factoryBackground', 3000);
			Object('Mine', 'mine|mines|mined', 'Mines out cookie dough and chocolate chips.', 'mine', 'mineIcon', 'mineBackground', 10000);
			Object('Shipment', 'shipment|shipments|shipped', 'Brings in fresh cookies from the cookie planet.', 'shipment', 'shipmentIcon', 'shipmentBackground', 40000);
			Object('Alchemy lab', 'alchemy lab|alchemy labs|transmuted', 'Turns gold into cookies!', 'alchemylab', 'alchemylabIcon', 'alchemylabBackground', 200000);
			Object('Portal', 'portal|portals|retrieved', 'Opens a door to the Cookieverse.', 'portal', 'portalIcon', 'portalBackground', 1666666);
			Object('Time machine', 'time machine|time machines|recovered', 'Brings cookies from the past, before they were even eaten.', 'timemachine', 'timemachineIcon', 'timemachineBackground', 123456789);
			Object('Antimatter condenser', 'antimatter condenser|antimatter condensers|condensed', 'Condenses the antimatter in the universe into cookies.', 'antimattercondenser', 'antimattercondenserIcon', 'antimattercondenserBackground', 3999999999);
			Object('Prism', 'prism|prisms|converted', 'Converts light itself into cookies.', 'prism', 'prismIcon', 'prismBackground', 50000000000);
		}
	}
}
