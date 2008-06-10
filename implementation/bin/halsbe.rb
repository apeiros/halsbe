$LOAD_PATH.unshift(File.expand_path("#{__FILE__}/../../lib"))

puts "$LOAD_PATH:", *$LOAD_PATH.map { |e| "  #{e}" }
puts
puts "ARGV: #{ARGV.inspect}"
puts
puts "ENV:", *ENV.sort.map { |e| "%32s: %s"%e }
