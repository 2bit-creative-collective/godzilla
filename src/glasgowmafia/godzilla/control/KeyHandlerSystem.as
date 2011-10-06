package glasgowmafia.godzilla.control
{
    import flash.ui.Keyboard;
    import ember.core.Game;
    import ember.core.Nodes;

    import glasgowmafia.godzilla.components.ControlComponent;
    import glasgowmafia.godzilla.components.PositionComponent;
    import glasgowmafia.godzilla.loop.GameLoopSignals;
    import org.osflash.signals.Signal;

    import flash.display.DisplayObjectContainer;
    import flash.display.Stage;
    import flash.events.KeyboardEvent;

    public class KeyHandlerSystem
    {
        protected static const LEFT_BIT:uint = 0x01;
        protected static const RIGHT_BIT:uint = 0x02;
        protected static const UP_BIT:uint = 0x04;
        protected static const DOWN_BIT:uint = 0x10;

        protected static const LEFT_KEY:int = Keyboard.LEFT;
        protected static const RIGHT_KEY:int = Keyboard.RIGHT;
        protected static const UP_KEY:int = Keyboard.UP;
        protected static const DOWN_KEY:int = Keyboard.DOWN;

        private var _xember:Game;
        private var _stage:Stage;

        private var _nodes:Nodes;
        private var _tick:Signal;

        private var _keysState:uint;

        public function KeyHandlerSystem(xember:Game, root:DisplayObjectContainer, signals:GameLoopSignals)
        {
            _xember = xember;
            _stage = root.stage;
            _tick = signals.user;
            _keysState = 0;
        }

        public function onRegister():void
        {
            _nodes = _xember.getNodes(ControlNode);

            _tick.add(iterate);

            _stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            _stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        }

        public function onRemove():void
        {
            _tick.remove(iterate);

            _stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            _stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        }

        private function onKeyDown(event:KeyboardEvent):void
        {
            var code:uint = event.keyCode;

            if(code == LEFT_KEY) _keysState |= LEFT_BIT;
            if(code == RIGHT_KEY) _keysState |= RIGHT_BIT;
            if(code == UP_KEY) _keysState |= UP_BIT;
            if(code == DOWN_KEY) _keysState |= DOWN_BIT;
        }

        private function onKeyUp(event:KeyboardEvent):void
        {
            var code:uint = event.keyCode;

            if(code == LEFT_KEY) _keysState &= ~LEFT_BIT;
            if(code == RIGHT_KEY) _keysState &= ~RIGHT_BIT;
            if(code == UP_KEY) _keysState &= ~UP_BIT;
            if(code == DOWN_KEY) _keysState &= ~DOWN_BIT;
        }

        private function iterate(timeDelta:uint):void
        {
            var node:ControlNode = _nodes.head as ControlNode;
            var position:PositionComponent = node.position;
            var velocity:int = 10;

            if(_keysState & LEFT_BIT)
            {
                position.rect.x -= velocity;
                position.changed = true;
            }
            if(_keysState & RIGHT_BIT)
            {
                position.rect.x += velocity;
                position.changed = true;
            }
            if(_keysState & DOWN_BIT)
            {
                position.rect.y += velocity;
                position.changed = true;
            }
            if(_keysState & UP_BIT)
            {
                position.rect.y -= velocity;
                position.changed = true;
            }
        }
        private function iteratex():void
        {
            var node:ControlNode = _nodes.head as ControlNode;

            var position:PositionComponent = node.position;
            var control:ControlComponent = node.control;

            var angle:Number = position.angle;
            var changed:Boolean = false;

            if (_keysState & LEFT_BIT || _keysState & RIGHT_BIT)
            {
                if (_keysState & LEFT_BIT)
                    angle += control.dAngle;

                if (_keysState & RIGHT_BIT)
                    angle -= control.dAngle;

                position.angle = angle;
                changed = true;
            }

            var dx:Number = 0;
            var dy:Number = 0;
            if (_keysState & UP_BIT || _keysState & DOWN_BIT)
            {
                if (_keysState & UP_BIT)
                {
                    dx -= Math.sin(angle) * control.velocity;
                    dy -= Math.cos(angle) * control.velocity;
                    changed = true;
                }

                if (_keysState & DOWN_BIT)
                {
                    dx += Math.sin(angle) * control.velocity;
                    dy += Math.cos(angle) * control.velocity;
                    changed = true;
                }

                position.rect.offset(dx, dy);
                position.changed = changed;
            }
        }

    }
}
