package glasgowmafia.godzilla.render.ctrl
{
    import ember.core.Game;

    import glasgowmafia.godzilla.render.Stage3DCameraSystem;
    import glasgowmafia.godzilla.render.Stage3DRenderSystem;

    public class CreateViewSystemsCommand
    {
        private var _xember:Game;

        public function CreateViewSystemsCommand(xember:Game)
        {
            _xember = xember;
        }

        public function execute():void
        {
            _xember.addSystem(Stage3DRenderSystem);
            _xember.addSystem(Stage3DCameraSystem);
        }
    }
}
