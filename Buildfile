require "buildr/as3"

# Custom layout for the source code and tests
custom_layout = Layout::Default.new
custom_layout[:source,:main,:as3] = "src"
custom_layout[:source,:test,:as3] = "test"

# Use a version of Flex SDK with FP11 and AIR 3 overlaid
FLEX_SDK = FlexSDK.new('4.5.1.21328_AIR3')
FLEX_SDK.from('https://s3.amazonaws.com/buildr-sdks/buildr/sdks/flex_sdk_4.5.1.21328_AIR3.zip')

APPARAT_TK = ApparatToolkit.new("1.0-RC9")

desc "The Godzilla project"
define "godzilla", :layout => custom_layout do
    # Work out some common paths and compile options
    common_source_libraries = array_path_to Buildr.settings.build['source_libraries']
    common_swc_libraries = array_path_to Buildr.settings.build['swc_libraries']
    common_bin = path_to "bin"
    common_other_options = [
        '-compiler.incremental=true', # Tough on compilation, tough on the causes of compilation
        '-static-link-runtime-shared-libraries=true', # Link everything
        '-optimize', # May as well optimise it
        '-swf-version=13' # New SWF version needed for Stage3D
    ]

    # Setup the compiler
    compile.using(
        :mxmlc,
        :flexsdk => FLEX_SDK,
        :main => _(:source, :main, :as3, 'Main.as')).
    from(common_source_libraries).
    with(common_swc_libraries).
    options[:args] = common_other_options

    compile.options[:apparat] = ApparatToolkit.new("1.0-RC9")
    compile { 
        apparat_tdsi :f => true, :a => true, :e => true, :m => true
        apparat_reducer :q => 0.9, :m => true, :s => true
    }

    # Output directory
    compile.into 'bin'

    # Test sources
    test.compile.sources = compile.sources
end

def array_path_to(paths)
    expanded = []
    paths.each { |p| expanded << path_to(p) }
    return expanded
end
