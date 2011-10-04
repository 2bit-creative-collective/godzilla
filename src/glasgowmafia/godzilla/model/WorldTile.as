package glasgowmafia.godzilla.model
{
	public class WorldTile
	{
		private var _color:uint;

		public function WorldTile(color:uint)
		{
			_color = color;
		}

		public function get color():uint
		{
			return _color;
		}
	}
}
