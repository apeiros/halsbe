$LOAD_PATH.unshift(File.expand_path("#{__FILE__}/../../lib"))

ARGV.shift
if ARGV.first == "--internals" then
	puts "$LOAD_PATH:", *$LOAD_PATH.map { |e| "  #{e}" }
	puts
	puts "ARGV: #{ARGV.inspect}"
	puts
	puts "ENV:", *ENV.sort.map { |e| "%32s: %s"%e }
	exit
end

require 'halsbe/vm'
script       = ARGV.shift
vm           = Halsbe::VM.new
vm.arguments = vm.nested_variable(:":List")
ARGV.map { |arg| vm.

vm.run_file script
