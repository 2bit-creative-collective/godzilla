package glasgowmafia.godzilla.sys.render
{
	import glasgowmafia.godzilla.components.RenderComponent;

	import flash.display.BitmapData;


	public class RenderFactory
	{

		private var _size:uint;

		public function RenderFactory(size:uint)
		{
			_size = size;
		}
		
		public function generateRender(x:int, y:int, color:uint):RenderComponent
		{
			var data:BitmapData = new BitmapData(_size, _size, false, color);
			
			var render:RenderComponent = new RenderComponent();
			render.data = data;
			render.rect = data.rect;
			render.x = x * _size;
			render.y = y * _size;
			
			return render;
		}
		
	}
}
