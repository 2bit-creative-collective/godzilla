package glasgowmafia.godzilla.components
{
    public class ControlComponent
    {
        public static const LEFT_BIT:uint = 0x01;
        public static const RIGHT_BIT:uint = 0x02;
        public static const UP_BIT:uint = 0x04;
        public static const DOWN_BIT:uint = 0x10;

        
        public var velocity:Number;
        public var direction:uint;
        public var dAngle:Number;
    }
}
