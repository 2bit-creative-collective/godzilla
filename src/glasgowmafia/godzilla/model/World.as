package glasgowmafia.godzilla.model
{
	public class World
	{

		private var _size:uint;
		private var _columns:uint;
		private var _rows:uint;

		private var _tiles:Vector.<WorldTile>;

		public function World(size:uint, columns:uint, rows:uint)
		{
			_size = size;
			_columns = columns;
			_rows = rows;
			
			_tiles = new Vector.<WorldTile>(columns * rows, true);
		}

		public function set(x:int, y:int, tile:WorldTile):void
		{
			_tiles[y * _columns + x] = tile;
		}
		
		public function get(x:int, y:int):WorldTile
		{
			return _tiles[y * _columns + x];
		}

		public function get size():uint
		{
			return _size;
		}
		
		public function get columns():uint
		{
			return _columns;
		}

		public function get rows():uint
		{
			return _rows;
		}
		
	}
}
