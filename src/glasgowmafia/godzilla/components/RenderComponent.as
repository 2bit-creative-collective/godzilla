package glasgowmafia.godzilla.components
{
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    public class RenderComponent
    {
        public var data:BitmapData;
        public var rect:Rectangle;
        public var offsetX:int = 0;
        public var offsetY:int = 0;
        //
        public var invalidate:Boolean;
    }
}
