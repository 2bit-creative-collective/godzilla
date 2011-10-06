package glasgowmafia.godzilla.render
{
    import ember.core.Game;
    import ember.core.Nodes;

    import glasgowmafia.godzilla.components.CameraComponent;
    import glasgowmafia.godzilla.loop.GameLoopSignals;
    import org.osflash.signals.Signal;

    public class Stage3DCameraSystem
    {
        //
        private var _xember:Game;
        //
        private var _nodes:Nodes;
        private var _tick:Signal;

        public function Stage3DCameraSystem(xember:Game, signals:GameLoopSignals)
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
            var camera:CameraComponent = node.camera;
            var camView:TokyoContainer = TokyoContainer.LAST_CREATED_INSTANCE;
            if(camView)
            {
                camView.x = -camera.x;
                camView.y = -camera.y;
                camView.rotation = camera.angle;
            }
        }
    }
}
