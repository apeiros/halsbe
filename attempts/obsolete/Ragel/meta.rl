%%{
	machine meta;

	alphtype int;

	LF               = 0x0a % { @line += 1 };
	AllButLF         = ascii - LF;
	AllButLFAndColon = ascii - LF - 0x3a;
	Align            = " "*;
	Indent           = "\t"*;
	MetaSeparator    = "+++" LF;
	Key              = AllButLFAndColon+ > { @start = p } % { puts "key '#{data[@start...p]}' on line #{@line}"; @start = p };
	Value            = AllButLF* > { @start = p } ( LF "\t" AllButLF* )* % { puts "value '#{data[@start...p]}' on line #{@line}"; @start = p };
	KeyValuePair     = Key ":" Align Value LF;
	Shebang          = ("#!" > { @start = p } AllButLF*) % { puts "shebang '#{data[@start...p]}' on line #{@line}"; @start = p } LF;
	Meta             = (Shebang > 2)? (KeyValuePair > 1)*;

	# instantiate machine rules
	main:= Meta;
}%%

%% write data;

def run_machine(data)
	@start = 0
	@line  = 1
  puts "Running the state machine with input:\n#{data.map{|l|'  '+l}}----------------------------------------"
  
  %% write init;
  %% write exec;
  
  puts "Finished. The state of the machine is: #{cs}"
  puts "p: #{p} pe: #{pe}"
end

run_machine "#!: foo\nKey: Value\nOther key: Other Value\n"
