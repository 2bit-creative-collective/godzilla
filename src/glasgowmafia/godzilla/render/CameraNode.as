package glasgowmafia.godzilla.render
{
    import glasgowmafia.godzilla.components.CameraComponent;
    import glasgowmafia.godzilla.components.PositionComponent;
    /**
     * @author mnem
     */
    public class CameraNode
    {
        // Linked list support
        public var prev:CameraNode;
        public var next:CameraNode;
        //
        [Ember(required)]
        public var camera:CameraComponent;
        // The target the camera is trying to show
        [Ember(required)]
        public var position:PositionComponent;
    }
}
