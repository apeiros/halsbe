require 'rubygems'
require 'halsbe_classes'
require 'halsbe'
require 'pp'

file   = ARGV[0] || "../code/simplehelloworld.halsbe"
parser = HalsbeParser.new
data   = File.read(file)
start  = Time.now
parsed = parser.parse(data)
stop   = Time.now
printf "It took %.2fs to parse %d lines (%.1fKB)\n", stop-start, data.count("\n"), data.length/1024.0

def purify(ast)
	#ast.reject { |e| e.first == :noop }.map { |e| purify(e) if }
end

if parsed then
	#puts parsed.tokenized
	ast = parsed.ast
	#ast2 = purify(ast)
	pp ast
	#p parsed
else
	puts "Failed to parse '#{file}': #{parser.failure_reason}"
	lines  = data.split(/\n/)
	digits = (Math.log(lines.size)/Math.log(10)).floor + 1
	format = "%0#{digits}d %s"
	slice  = ([0,parser.failure_line-2].max)..([lines.size,parser.failure_line+2].min)
	puts
	puts (1..lines.size).zip(lines).map { |i,l| format %  [i, l] }[slice]
end
