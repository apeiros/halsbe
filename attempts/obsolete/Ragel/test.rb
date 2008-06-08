# line 1 "../../Ragel/test.rl"
# line 478 "../../Ragel/test.rl"


require 'ostructfixed'
require 'halsbe/tokens'
require 'pp'

module Kernel
	def secure(area)
		yield
	rescue Exception => e
		puts area, e, *e.backtrace
	end
end

module Halsbe
	class Parser
		def self.parse_file(path)
			path = File.expand_path(path)
			parser = new
			parser.parse(File.read(path), path)
			parser
		end
		
		attr_reader :ast
		attr_reader :tokens
		attr_reader :data
		attr_reader :file
		
		def initialize
		
# line 34 "../../Ragel/test.rb"
class << self
	attr_accessor :_halsbe_actions
	private :_halsbe_actions, :_halsbe_actions=
end
self._halsbe_actions = [
	0, 1, 0, 1, 2, 1, 4, 1, 
	5, 1, 15, 1, 16, 1, 18, 1, 
	19, 1, 25, 1, 27, 1, 28, 2, 
	3, 1, 2, 7, 1, 2, 8, 1, 
	2, 9, 15, 2, 11, 15, 2, 12, 
	13, 2, 14, 1, 2, 15, 19, 2, 
	16, 1, 2, 16, 6, 2, 16, 18, 
	2, 16, 21, 2, 17, 15, 2, 19, 
	15, 2, 19, 21, 2, 19, 28, 2, 
	23, 24, 2, 29, 18, 2, 34, 15, 
	3, 9, 10, 0, 3, 9, 15, 16, 
	3, 11, 15, 16, 3, 15, 16, 18, 
	3, 16, 1, 19, 3, 16, 19, 21, 
	3, 16, 19, 22, 3, 19, 15, 16, 
	3, 20, 19, 26, 3, 20, 19, 30, 
	3, 20, 19, 33, 3, 34, 15, 16, 
	4, 9, 15, 16, 1, 4, 12, 13, 
	14, 1, 4, 15, 16, 1, 19, 4, 
	15, 16, 19, 21, 4, 15, 16, 19, 
	22, 4, 16, 6, 7, 1, 4, 17, 
	15, 16, 6, 4, 17, 15, 16, 21, 
	4, 28, 31, 32, 15, 4, 34, 15, 
	16, 1, 5, 16, 19, 31, 32, 15, 
	5, 25, 28, 31, 32, 15, 5, 27, 
	28, 31, 32, 15, 5, 28, 31, 32, 
	15, 16, 6, 16, 19, 28, 31, 32, 
	15, 6, 17, 15, 16, 6, 7, 1, 
	6, 20, 19, 30, 15, 31, 32, 6, 
	25, 28, 31, 32, 15, 16, 6, 27, 
	28, 31, 32, 15, 16, 6, 28, 31, 
	32, 15, 16, 1, 7, 16, 19, 28, 
	31, 32, 15, 1, 7, 25, 28, 31, 
	32, 15, 16, 1, 7, 27, 28, 31, 
	32, 15, 16, 1, 8, 20, 19, 30, 
	28, 31, 32, 15, 16, 9, 20, 19, 
	30, 28, 31, 32, 15, 16, 1
]

class << self
	attr_accessor :_halsbe_key_offsets
	private :_halsbe_key_offsets, :_halsbe_key_offsets=
end
self._halsbe_key_offsets = [
	0, 0, 9, 10, 11, 19, 20, 21, 
	22, 32, 34, 35, 36, 37, 40, 45, 
	50, 54, 58, 63, 68, 72, 75, 78, 
	86, 87, 89, 98, 101, 112, 119, 120, 
	122, 126, 129, 130, 135, 140, 148, 149, 
	151, 152, 154, 158, 163, 164, 166, 168, 
	171, 176, 181, 189, 190, 192, 193, 195, 
	197, 205, 207, 209, 210, 212, 215, 223, 
	225, 226
]

class << self
	attr_accessor :_halsbe_trans_keys
	private :_halsbe_trans_keys, :_halsbe_trans_keys=
end
self._halsbe_trans_keys = [
	35, 43, 95, 48, 57, 65, 90, 97, 
	122, 33, 10, 43, 95, 48, 57, 65, 
	90, 97, 122, 43, 43, 10, 9, 10, 
	32, 45, 58, 95, 65, 90, 97, 122, 
	9, 45, 45, 45, 10, 10, -128, 127, 
	9, 10, 45, -128, 127, 9, 10, 45, 
	-128, 127, 10, 45, -128, 127, 10, 45, 
	-128, 127, 10, 32, 47, -128, 127, 10, 
	32, 47, -128, 127, 10, 47, -128, 127, 
	10, -128, 127, 10, -128, 127, 10, 32, 
	58, 95, 65, 90, 97, 122, 58, 65, 
	90, 46, 58, 95, 48, 57, 65, 90, 
	97, 122, 95, 97, 122, 10, 32, 40, 
	47, 95, 48, 57, 65, 90, 97, 122, 
	10, 32, 37, 47, 95, 97, 122, 39, 
	10, 39, 10, 32, 44, 47, 10, 32, 
	47, 47, 32, 37, 95, 97, 122, 32, 
	37, 95, 97, 122, 58, 95, 48, 57, 
	65, 90, 97, 122, 32, 32, 37, 39, 
	10, 39, 10, 32, 44, 47, 37, 41, 
	95, 97, 122, 39, 10, 39, 41, 44, 
	10, 32, 47, 32, 37, 95, 97, 122, 
	32, 37, 95, 97, 122, 58, 95, 48, 
	57, 65, 90, 97, 122, 32, 32, 37, 
	39, 10, 39, 41, 44, 58, 95, 48, 
	57, 65, 90, 97, 122, 32, 37, 32, 
	37, 39, 10, 39, 10, 32, 47, 58, 
	95, 48, 57, 65, 90, 97, 122, 10, 
	32, 10, 10, 32, 0
]

class << self
	attr_accessor :_halsbe_single_lengths
	private :_halsbe_single_lengths, :_halsbe_single_lengths=
end
self._halsbe_single_lengths = [
	0, 3, 1, 1, 2, 1, 1, 1, 
	6, 2, 1, 1, 1, 1, 3, 3, 
	2, 2, 3, 3, 2, 1, 1, 4, 
	1, 0, 3, 1, 5, 5, 1, 2, 
	4, 3, 1, 3, 3, 2, 1, 2, 
	1, 2, 4, 3, 1, 2, 2, 3, 
	3, 3, 2, 1, 2, 1, 2, 2, 
	2, 2, 2, 1, 2, 3, 2, 2, 
	1, 2
]

class << self
	attr_accessor :_halsbe_range_lengths
	private :_halsbe_range_lengths, :_halsbe_range_lengths=
end
self._halsbe_range_lengths = [
	0, 3, 0, 0, 3, 0, 0, 0, 
	2, 0, 0, 0, 0, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 2, 
	0, 1, 3, 1, 3, 1, 0, 0, 
	0, 0, 0, 1, 1, 3, 0, 0, 
	0, 0, 0, 1, 0, 0, 0, 0, 
	1, 1, 3, 0, 0, 0, 0, 0, 
	3, 0, 0, 0, 0, 0, 3, 0, 
	0, 0
]

class << self
	attr_accessor :_halsbe_index_offsets
	private :_halsbe_index_offsets, :_halsbe_index_offsets=
end
self._halsbe_index_offsets = [
	0, 0, 7, 9, 11, 17, 19, 21, 
	23, 32, 35, 37, 39, 41, 44, 49, 
	54, 58, 62, 67, 72, 76, 79, 82, 
	89, 91, 93, 100, 103, 112, 119, 121, 
	124, 129, 133, 135, 140, 145, 151, 153, 
	156, 158, 161, 166, 171, 173, 176, 179, 
	183, 188, 193, 199, 201, 204, 206, 209, 
	212, 218, 221, 224, 226, 229, 233, 239, 
	242, 244
]

class << self
	attr_accessor :_halsbe_trans_targs_wi
	private :_halsbe_trans_targs_wi, :_halsbe_trans_targs_wi=
end
self._halsbe_trans_targs_wi = [
	2, 5, 62, 62, 62, 62, 0, 3, 
	0, 4, 3, 5, 62, 62, 62, 62, 
	0, 6, 0, 7, 0, 8, 0, 9, 
	8, 23, 10, 24, 56, 26, 56, 0, 
	9, 10, 0, 11, 0, 12, 0, 13, 
	0, 14, 13, 0, 15, 14, 16, 13, 
	0, 15, 14, 16, 13, 0, 14, 17, 
	13, 0, 14, 18, 13, 0, 8, 19, 
	20, 13, 0, 8, 19, 20, 13, 0, 
	14, 21, 13, 0, 8, 22, 0, 8, 
	22, 0, 8, 23, 24, 56, 26, 56, 
	0, 25, 0, 26, 0, 27, 24, 26, 
	26, 26, 26, 0, 28, 28, 0, 8, 
	29, 43, 34, 28, 28, 28, 28, 0, 
	8, 29, 30, 34, 37, 37, 0, 31, 
	0, 31, 32, 31, 8, 33, 35, 34, 
	0, 8, 33, 34, 0, 21, 0, 36, 
	30, 37, 37, 0, 36, 30, 37, 37, 
	0, 38, 37, 37, 37, 37, 0, 39, 
	0, 39, 40, 0, 41, 0, 41, 42, 
	41, 8, 33, 35, 34, 0, 44, 47, 
	50, 50, 0, 45, 0, 45, 46, 45, 
	47, 48, 0, 8, 33, 34, 0, 49, 
	44, 50, 50, 0, 49, 44, 50, 50, 
	0, 51, 50, 50, 50, 50, 0, 52, 
	0, 52, 53, 0, 54, 0, 54, 55, 
	54, 47, 48, 0, 57, 56, 56, 56, 
	56, 0, 58, 59, 0, 58, 59, 0, 
	60, 0, 60, 61, 60, 8, 33, 34, 
	0, 63, 62, 62, 62, 62, 0, 4, 
	65, 64, 4, 64, 4, 65, 64, 0
]

class << self
	attr_accessor :_halsbe_trans_actions_wi
	private :_halsbe_trans_actions_wi, :_halsbe_trans_actions_wi=
end
self._halsbe_trans_actions_wi = [
	3, 0, 5, 5, 5, 5, 0, 0, 
	0, 23, 0, 0, 5, 5, 5, 5, 
	0, 0, 0, 0, 0, 29, 0, 62, 
	138, 44, 108, 148, 92, 148, 92, 15, 
	0, 11, 0, 0, 0, 0, 0, 80, 
	0, 1, 0, 0, 35, 1, 88, 0, 
	0, 0, 1, 11, 0, 0, 1, 0, 
	0, 0, 1, 0, 0, 0, 128, 32, 
	84, 0, 0, 47, 0, 11, 0, 0, 
	1, 0, 0, 0, 133, 38, 0, 41, 
	0, 0, 96, 15, 104, 53, 104, 53, 
	15, 0, 0, 0, 0, 71, 0, 0, 
	0, 0, 0, 0, 74, 74, 15, 277, 
	216, 116, 268, 21, 21, 21, 21, 68, 
	244, 178, 100, 202, 53, 53, 68, 0, 
	21, 1, 0, 0, 252, 184, 17, 223, 
	21, 47, 0, 11, 0, 0, 0, 44, 
	143, 92, 92, 68, 15, 100, 53, 53, 
	68, 112, 0, 0, 0, 0, 68, 9, 
	21, 0, 56, 21, 0, 21, 1, 0, 
	0, 260, 190, 19, 230, 21, 65, 15, 
	13, 13, 68, 0, 21, 1, 0, 0, 
	17, 17, 21, 237, 168, 196, 21, 44, 
	143, 92, 92, 68, 15, 100, 53, 53, 
	68, 112, 0, 0, 0, 0, 68, 9, 
	21, 0, 56, 21, 0, 21, 1, 0, 
	0, 19, 19, 21, 120, 0, 0, 0, 
	0, 15, 59, 163, 0, 0, 56, 0, 
	0, 0, 1, 0, 0, 173, 77, 124, 
	0, 7, 0, 0, 0, 0, 0, 209, 
	59, 158, 26, 0, 153, 0, 50, 0
]

class << self
	attr_accessor :_halsbe_eof_actions
	private :_halsbe_eof_actions, :_halsbe_eof_actions=
end
self._halsbe_eof_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	15, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 15, 
	0, 0, 0, 15, 21, 15, 21, 21, 
	0, 0, 0, 68, 68, 21, 21, 21, 
	21, 21, 0, 68, 21, 21, 21, 0, 
	68, 68, 21, 21, 21, 21, 21, 21, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0
]

class << self
	attr_accessor :halsbe_start
end
self.halsbe_start = 1;
class << self
	attr_accessor :halsbe_first_final
end
self.halsbe_first_final = 66;
class << self
	attr_accessor :halsbe_error
end
self.halsbe_error = 0;

class << self
	attr_accessor :halsbe_en_main
end
self.halsbe_en_main = 1;

# line 508 "../../Ragel/test.rl"
	
			@pos = 0
			@cs  = halsbe_start
		end
	
		def parse(data, file='(eval)', line=1)
			@meta    = {}
			@shebang = nil
		
			@data   = data
			@pos    = 0
			@off    = 0
			@pe     = data.length
			@line   = line
			@mark   = OpenStruct.new
			@file   = file
			@tokens = []
			@ast    = [:statement, []]
			@stack  = [@ast.last]
		
			
# line 310 "../../Ragel/test.rb"
begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if     @pos ==    @pe
		_goto_level = _test_eof
		next
	end
	if    @cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_keys = _halsbe_key_offsets[   @cs]
	_trans = _halsbe_index_offsets[   @cs]
	_klen = _halsbe_single_lengths[   @cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if  @data[    @pos] < _halsbe_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif  @data[    @pos] > _halsbe_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _halsbe_range_lengths[   @cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if  @data[    @pos] < _halsbe_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif  @data[    @pos] > _halsbe_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	   @cs = _halsbe_trans_targs_wi[_trans]
	if _halsbe_trans_actions_wi[_trans] != 0
		_acts = _halsbe_trans_actions_wi[_trans]
		_nacts = _halsbe_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _halsbe_actions[_acts - 1]
when 0 then
# line 28 "../../Ragel/test.rl"
		begin

		@line += 1
		@off   = @pos+1
			end
# line 28 "../../Ragel/test.rl"
when 1 then
# line 32 "../../Ragel/test.rl"
		begin

		secure(:newline) {
			@tokens << Token::Newline.new(
				@line,
				char,
				@pos,
				1
			)
		}
		@line += 1
		@off   = @pos+1
			end
# line 32 "../../Ragel/test.rl"
when 2 then
# line 44 "../../Ragel/test.rl"
		begin

		@mark.shebang = @pos
			end
# line 44 "../../Ragel/test.rl"
when 3 then
# line 47 "../../Ragel/test.rl"
		begin

		secure(:shebang) {
			start    = @mark.shebang
			length   = @pos-start
			@shebang = @data[start, length]
			@tokens << Token::Shebang.new(
				@line,
				char,
				start,
				length
			)
		}
			end
# line 47 "../../Ragel/test.rl"
when 4 then
# line 60 "../../Ragel/test.rl"
		begin

		@mark.meta_key = @pos
			end
# line 60 "../../Ragel/test.rl"
when 5 then
# line 63 "../../Ragel/test.rl"
		begin

		secure(:meta_key) {
			start     = @mark.meta_key
			length    = @pos-start
			@meta_key = @data[start, length]
			@tokens << Token::MetaKey.new(
				@line,
				char,
				start,
				length
			)
		}
			end
# line 63 "../../Ragel/test.rl"
when 6 then
# line 76 "../../Ragel/test.rl"
		begin

		@mark.meta_value = @pos
			end
# line 76 "../../Ragel/test.rl"
when 7 then
# line 79 "../../Ragel/test.rl"
		begin

		secure(:meta_value) {
			start  = @mark.meta_value
			length = @pos-start
			@meta[@meta_key] = @data[start, length]
			@tokens << Token::MetaValue.new(
				@line,
				char,
				start,
				length
			)
		}
			end
# line 79 "../../Ragel/test.rl"
when 8 then
# line 92 "../../Ragel/test.rl"
		begin

		secure(:meta_separator) {
			@tokens << Token::MetaSeparator.new(
				@line,
				char,
				@pos-3,
				3
			)
		}
			end
# line 92 "../../Ragel/test.rl"
when 9 then
# line 103 "../../Ragel/test.rl"
		begin

		secure(:doc_comment_sep) {
			@tokens << Token::DocCommentSep.new(
				@line,
				char,
				@pos-3,
				3
			)
		}
			end
# line 103 "../../Ragel/test.rl"
when 10 then
# line 113 "../../Ragel/test.rl"
		begin

		@mark.doc_comment = @pos
			end
# line 113 "../../Ragel/test.rl"
when 11 then
# line 116 "../../Ragel/test.rl"
		begin

		secure(:doc_comment) {
			start  = @mark.doc_comment
			length = @pos-start
			@tokens << Token::DocComment.new(
				@line,
				char,
				start,
				length
			)
		}
			end
# line 116 "../../Ragel/test.rl"
when 12 then
# line 130 "../../Ragel/test.rl"
		begin

		secure(:sl_comment_sep) {
			@tokens << Token::SLCommentSep.new(
				@line,
				char,
				@pos-2,
				2
			)
		}
			end
# line 130 "../../Ragel/test.rl"
when 13 then
# line 140 "../../Ragel/test.rl"
		begin

		@mark.sl_comment = @pos
			end
# line 140 "../../Ragel/test.rl"
when 14 then
# line 143 "../../Ragel/test.rl"
		begin

		secure(:sl_comment) {
			start  = @mark.sl_comment
			length = @pos-start
			@tokens << Token::SLComment.new(
				@line,
				char,
				start,
				length
			)
		}
			end
# line 143 "../../Ragel/test.rl"
when 15 then
# line 157 "../../Ragel/test.rl"
		begin

		@mark.whitespace = @pos
			end
# line 157 "../../Ragel/test.rl"
when 16 then
# line 160 "../../Ragel/test.rl"
		begin

		secure(:whitespace) {
			@tokens << Token::Whitespace.new(
				@line,
				char,
				@mark.whitespace,
				@pos-@mark.whitespace
			) if @mark.whitespace
			@mark.whitespace = nil
		}
			end
# line 160 "../../Ragel/test.rl"
when 17 then
# line 172 "../../Ragel/test.rl"
		begin

		secure(:assign) {
			@tokens << Token::Assign.new(
				@line,
				char,
				@pos-1,
				1
			)
		}
			end
# line 172 "../../Ragel/test.rl"
when 18 then
# line 184 "../../Ragel/test.rl"
		begin

		@mark.identifier ||= @pos
			end
# line 184 "../../Ragel/test.rl"
when 19 then
# line 187 "../../Ragel/test.rl"
		begin

		@mark.identifier = nil
			end
# line 187 "../../Ragel/test.rl"
when 20 then
# line 190 "../../Ragel/test.rl"
		begin

		secure(:identifier) {
			@tokens << Token::Identifier.new(
				@line,
				char,
				@mark.identifier,
				@pos-@mark.identifier
			)
		}
			end
# line 190 "../../Ragel/test.rl"
when 21 then
# line 201 "../../Ragel/test.rl"
		begin

		puts "literal_start #{position}"
		@mark.literal = @pos
			end
# line 201 "../../Ragel/test.rl"
when 22 then
# line 280 "../../Ragel/test.rl"
		begin

		@mark.constant = @pos
			end
# line 280 "../../Ragel/test.rl"
when 23 then
# line 283 "../../Ragel/test.rl"
		begin

		secure(:constant) {
			@tokens << Token::Constant.new(
				@line,
				char,
				@mark.constant,
				length = @pos-@mark.constant
			)
			@stack.last << [:constant, @data[@mark.constant, length]]
		}
			end
# line 283 "../../Ragel/test.rl"
when 24 then
# line 294 "../../Ragel/test.rl"
		begin

		@tokens << Token::ChainMethod.new(
			@line,
			char,
			@pos,
			1
		)
			end
# line 294 "../../Ragel/test.rl"
when 25 then
# line 303 "../../Ragel/test.rl"
		begin

		puts "unnamed_argument_value"
		@stack.last << [nil, @stack.last.pop]
			end
# line 303 "../../Ragel/test.rl"
when 26 then
# line 307 "../../Ragel/test.rl"
		begin

		@stack.last << [@data[@pos, length]]
		@stack << []
			end
# line 307 "../../Ragel/test.rl"
when 27 then
# line 311 "../../Ragel/test.rl"
		begin

		@stack.last << @stack.pop
		@stack.pop
			end
# line 311 "../../Ragel/test.rl"
when 28 then
# line 315 "../../Ragel/test.rl"
		begin

		#puts "abort arguments #{position}"
			end
# line 315 "../../Ragel/test.rl"
when 29 then
# line 330 "../../Ragel/test.rl"
		begin

		puts "method_call_create"
		@stack.last << [:call, @stack.last.pop, nil, []]
		@stack << @stack.last.last
			end
# line 330 "../../Ragel/test.rl"
when 30 then
# line 335 "../../Ragel/test.rl"
		begin

		puts "method_call_name"
		@stack.last[2] = last_token_data.to_sym
		@stack << @stack.last.last # arguments on top of the stack
			end
# line 335 "../../Ragel/test.rl"
when 31 then
# line 340 "../../Ragel/test.rl"
		begin

		puts "method_call_arguments_end #{position}"
		@stack.pop
			end
# line 340 "../../Ragel/test.rl"
when 32 then
# line 344 "../../Ragel/test.rl"
		begin

		puts "method_call_end"
		@stack.pop
			end
# line 344 "../../Ragel/test.rl"
when 33 then
# line 355 "../../Ragel/test.rl"
		begin

		@stack.last << [:assign, last_token_data]
		@stack << @stack.last.last
			end
# line 355 "../../Ragel/test.rl"
when 34 then
# line 359 "../../Ragel/test.rl"
		begin

		puts "assign done"
		@stack.pop
			end
# line 359 "../../Ragel/test.rl"
# line 761 "../../Ragel/test.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	if    @cs == 0
		_goto_level = _out
		next
	end
	    @pos += 1
	if     @pos !=    @pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	if     @pos == eof
	__acts = _halsbe_eof_actions[   @cs]
	__nacts =  _halsbe_actions[__acts]
	__acts += 1
	while __nacts > 0
		__nacts -= 1
		__acts += 1
		case _halsbe_actions[__acts - 1]
when 19 then
# line 187 "../../Ragel/test.rl"
		begin

		@mark.identifier = nil
			end
# line 187 "../../Ragel/test.rl"
when 28 then
# line 315 "../../Ragel/test.rl"
		begin

		#puts "abort arguments #{position}"
			end
# line 315 "../../Ragel/test.rl"
# line 803 "../../Ragel/test.rb"
		end # eof action switch
	end
	if _trigger_goto
		next
	end
end
	end
	if _goto_level <= _out
		break
	end
	end
	end
# line 529 "../../Ragel/test.rl"
		end
		
		def reset
			@mark = OpenStruct.new
		end
		
		def char
			@pos-@off
		end
		
		def last_token_data(n=nil)
			n ? @tokens[-n].data(@data) : @tokens.last.data(@data)
		end
		
		def position
			"#{File.basename(@file)}:#{@line}:#{@pos-@off}"
		end
	end
end
