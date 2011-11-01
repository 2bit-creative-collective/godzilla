require "buildr/as3"

# Custom layout for the source code and tests
custom_layout = Layout::Default.new
custom_layout[:source,:main,:as3] = "src"
custom_layout[:source,:test,:as3] = "test"

# Use a version of Flex SDK with FP11 and AIR 3 overlaid
FLEX_SDK = FlexSDK.new('4.5.1.21328_AIR3')
FLEX_SDK.from('https://s3.amazonaws.com/buildr-sdks/buildr/sdks/flex_sdk_4.5.1.21328_AIR3.zip')

desc "The Godzilla project"
define "godzilla", :layout => custom_layout do
    compile.using :mxmlc,
                  :flexsdk => FLEX_SDK,
                  :main => _(:source, :main, :as3, 'Main.as')
    
    # Source libraries
    compile.from [
        _(:submodules, :'as3-signals', :src),
        _(:submodules, :'Starling-Framework', :starling, :src),
        _(:submodules, :xember, :as3, :src)
    ]

    # SWC libraries
    compile.with [
        _(:libs, :'robotlegs-framework-v1.4.0.swc')
    ]

    # Compile options
    compile.options[:other] = [
        '-compiler.incremental=true', # Tough on compilation, tough on the causes of compilation
        '-static-link-runtime-shared-libraries=true', # Link everything
        '-optimize', # May as well optimise it
        '-swf-version=13' # New SWF version needed for Stage3D
    ]

    test.compile.sources = compile.sources

    # Output directory
    compile.into 'bin'
end
