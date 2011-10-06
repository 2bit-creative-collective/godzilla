package glasgowmafia.godzilla.render
{
    import glasgowmafia.godzilla.components.PositionComponent;
    import glasgowmafia.godzilla.components.RenderComponent;

    import starling.display.Image;

    import flash.display.Bitmap;

    public class RenderNode
    {
        // Linked list support
        public var prev:RenderNode;
        public var next:RenderNode;
        //
        [Ember(required)]
        public var render:RenderComponent;
        //
        [Ember(required)]
        public var position:PositionComponent;
        //
        [Ember(ignore)]
        public var bitmap:Bitmap;
        // Starling textured quad
        [Ember(ignore)]
        public var quad:Image;
    }
}
