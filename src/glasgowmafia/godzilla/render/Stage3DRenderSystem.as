package glasgowmafia.godzilla.render
{
    import ember.core.Game;
    import ember.core.Nodes;

    import glasgowmafia.godzilla.loop.GameLoopSignals;
    import org.osflash.signals.Signal;
    import glasgowmafia.godzilla.components.CameraComponent;
    import glasgowmafia.godzilla.components.PositionComponent;
    import glasgowmafia.godzilla.components.RenderComponent;

    import starling.core.Starling;
    import starling.display.Image;
    import starling.textures.Texture;

    import flash.display.DisplayObjectContainer;
    import flash.events.Event;

    public class Stage3DRenderSystem
    {
        private var _xember:Game;
        private var _root:DisplayObjectContainer;
        private var _tick:Signal;
        private var _nodes:Nodes;
        private var _starling:Starling;

        public function Stage3DRenderSystem(xember:Game, root:DisplayObjectContainer, signals:GameLoopSignals)
        {
            _xember = xember;
            _root = root;
            _tick = signals.render;
        }

        private function onContextCreated(event:Event):void
        {
            _nodes = _xember.getNodes(RenderNode);
            _nodes.nodeAdded.add(addNode);
            _nodes.nodeRemoved.add(removeNode);
            addAllNodes(_nodes);

            _tick.add(iterate);

            _starling.start();
        }

        public function onRegister():void
        {
            _root.stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, onContextCreated, false, int.MIN_VALUE);
            /*FDT_IGNORE*/
            _starling = new Starling(TokyoContainer, _root.stage, null, _root.stage.stage3Ds[0]);
            /*FDT_IGNORE*/
        }

        public function onRemove():void
        {
            _starling.stop();
            _starling.dispose();

            _tick.remove(iterate);
        }

        private function iterate(timeDelta:uint):void
        {
            for (var node:RenderNode = _nodes.head as RenderNode; node; node = node.next)
            {
                var position:PositionComponent = node.position;
                var render:RenderComponent = node.render;
                var quad:Image = node.quad;
                if (!position.changed && !render.invalidate)
                    continue;

                quad.x = position.rect.x;
                quad.y = position.rect.y;

                position.changed = false;
                render.invalidate = false;
            }
        }

        private function addAllNodes(nodes:Nodes):void
        {
            for (var node:RenderNode = nodes.head as RenderNode; node; node = node.next)
            {
                addNode(node);
            }
        }

        private function addNode(node:RenderNode):void
        {
            var position:PositionComponent = node.position;
            var quad:Image = new Image(Texture.fromBitmapData(node.render.data));

            quad.x = position.rect.x;
            quad.y = position.rect.y;

            node.quad = quad;

            TokyoContainer.LAST_CREATED_INSTANCE.addChild(node.quad);

            node.render.invalidate = true;
        }

        private function removeNode(node:RenderNode):void
        {
            var quad:Image = node.quad;

            TokyoContainer.LAST_CREATED_INSTANCE.removeChild(node.quad);

            quad.dispose();
            node.quad = null;
        }
    }
}
