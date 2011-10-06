package glasgowmafia.godzilla.render
{
    import starling.display.Sprite;

    /**
     * @author mnem
     */
    public class TokyoContainer
    extends Sprite
    {
        public static var LAST_CREATED_INSTANCE:TokyoContainer;

        public function TokyoContainer()
        {
            LAST_CREATED_INSTANCE = this;
        }
    }
}
