package glasgowmafia.godzilla.control
{
    import ember.core.Game;
    import ember.core.Nodes;

    import glasgowmafia.godzilla.components.CameraComponent;
    import glasgowmafia.godzilla.components.PositionComponent;
    import glasgowmafia.godzilla.render.CameraNode;
    import glasgowmafia.godzilla.loop.GameLoopSignals;
    import org.osflash.signals.Signal;

    import flash.display.DisplayObjectContainer;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class UpdateCameraSystem
    {
        private static const PI:Number = Math.PI;
        private static const HALF_PI:Number = Math.PI * .5;
        //
        private var _xember:Game;
        //
        private var _nodes:Nodes;
        private var _tick:Signal;

        public function UpdateCameraSystem(xember:Game, signals:GameLoopSignals)
        {
            _xember = xember;
            _tick = signals.render;
        }

        public function onRegister():void
        {
            _nodes = _xember.getNodes(CameraNode);
            _tick.add(iterate);
        }

        public function onRemove():void
        {
            _tick.remove(iterate);
        }

        private function iterate(timeDelta:uint):void
        {
            var node:CameraNode = _nodes.head as CameraNode;
            var position:PositionComponent = node.position;
            var camera:CameraComponent = node.camera;

            var rect:Rectangle = position.rect;
            var targetPoint:Point = new Point(rect.x - 400 /* half screen */, rect.y - 300  /* half screen */);

            var xD:Number = targetPoint.x - camera.x;
            var yD:Number = targetPoint.y - camera.y;

            camera.x += xD > 0 ? Math.min(camera.maxDPosition, xD) : Math.max(-camera.maxDPosition, xD);
            camera.y += yD > 0 ? Math.min(camera.maxDPosition, yD) : Math.max(-camera.maxDPosition, yD);
        }
    }
}
