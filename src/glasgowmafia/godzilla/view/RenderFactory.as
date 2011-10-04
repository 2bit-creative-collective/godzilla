package glasgowmafia.godzilla.view
{
	import glasgowmafia.godzilla.model.World;
	import glasgowmafia.godzilla.model.WorldTile;
	import glasgowmafia.godzilla.sys.render.RenderComponent;

	import flash.display.BitmapData;
	import flash.geom.Point;
	
	public class RenderFactory
	{

		private var _world:World;

		public function RenderFactory(world:World)
		{
			_world = world;
		}
		
		public function generateRender(x:int, y:int, tile:WorldTile):RenderComponent
		{
			var size:uint = _world.size;
			
			var data:BitmapData = new BitmapData(size, size, false, tile.color);
			var position:Point = new Point(x * size, y * size);
			
			var render:RenderComponent = new RenderComponent();
			render.data = data;
			render.rect = data.rect;
			render.position = position;
			
			return render;
		}
		
	}
}
