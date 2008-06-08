puts $$
puts "forking webrick"
fork {
	begin
		exec("ruby #{File.expand_path('serve.rb')}")
	rescue Exception => e
		File.open("log.txt", "wb") { |fh| fh.puts e, *e.backtrace }
	end
}
puts "back"
puts $$
sleep 10
puts "ending"