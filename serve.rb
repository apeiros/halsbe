require 'webrick'
include WEBrick
s = HTTPServer.new(
	:Port         => 9951,
	:DocumentRoot => File.expand_path(File.dirname(__FILE__)) 
)
s.config[:MimeTypes].update({
	"rl"      => "text/plain",
	"halsbe"  => "text/plain",
	"treetop" => "text/plain",
})
trap("INT") { s.stop }
s.start
