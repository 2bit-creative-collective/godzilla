package glasgowmafia.godzilla.model
{
	public class Grid
	{
		
		private var _size:uint;

		public function Grid(size:uint)
		{
			_size = size;
		}
		
		public function get size():uint
		{
			return _size;
		}

		
	}
}
