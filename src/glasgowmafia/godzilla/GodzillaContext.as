package glasgowmafia.godzilla
{
    import glasgowmafia.godzilla.physical.ctrl.CreateCollisionDetectionSystemCommand;
    import alecmce.random.Random;

    import ember.core.Game;

	import glasgowmafia.godzilla.control.ctrl.CreateControllerSystemsCommand;
	import glasgowmafia.godzilla.init.ctrl.CreateDummyGodzillaCommand;
	import glasgowmafia.godzilla.init.ctrl.DefineRandomWorldCommand;
	import glasgowmafia.godzilla.loop.ctrl.CreateMainGameLoopCommand;
	import glasgowmafia.godzilla.physical.ctrl.CreatePhysicalSystemCommand;
	import glasgowmafia.godzilla.render.ctrl.CreateViewSystemsCommand;

    import org.robotlegs.mvcs.Context;

    import flash.display.DisplayObjectContainer;

    public class GodzillaContext extends Context
    {
        public function GodzillaContext(root:DisplayObjectContainer)
        {
            super(root, true);

            injector.mapValue(Random, new Random(4));

            injector.mapSingleton(Game);

						commandMap.execute(CreateMainGameLoopCommand);
            commandMap.execute(DefineRandomWorldCommand);
            commandMap.execute(CreateDummyGodzillaCommand);
            commandMap.execute(CreateCollisionDetectionSystemCommand);
            commandMap.execute(CreateViewSystemsCommand);
            //commandMap.execute(CreatePhysicalSystemCommand);
            commandMap.execute(CreateControllerSystemsCommand);
        }
    }
}
