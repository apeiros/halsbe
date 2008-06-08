require 'enumerator'
require 'pp'
class MethodLookupTrie
	Terminator = "\0".freeze
	Splitter   = //.freeze

	attr_reader :trie

	def initialize(words)
		trie = [[Terminator]]
		words.sort.each { |word, address|
			subtrie = trie
			word.split(Splitter).each { |char|
				subtrie << [char, [[Terminator]]] unless subtrie.last.first == char
				subtrie = subtrie.last.last
			}
			raise "Twice the same method name #{word}" unless subtrie.last.length == 1
			subtrie.last << address
		}
		trie.shift # get rid of the initial terminator
		compact(trie)
		concat(trie)
		@trie = trie
	end
	private
	def compact(trie)
		trie.delete([Terminator])
		trie.each { |char, subtrie|
			compact(subtrie) if Array === subtrie
		}
	end
	def concat(trie)
		puts ":concat, #{trie.inspect[0,80]}"
		if trie.length == 1 then
			p [:length1, trie]
			subtrie = trie.first
			while Array === subtrie.last && subtrie.last.length == 1
				subtrie.first << subtrie.last.first.first
				subtrie[-1] = subtrie.last.first.last
			end
			p [:descend, subtrie.last]
			concat(subtrie.last) if Array === subtrie.last
		else
			trie.each { |char, subtrie|
				concat(subtrie) if Array === subtrie
			}
		end
	end
	def first_diff(a,b)
		a,b = b,a if a.size < b.size
		(0...a.size).zip(a.unpack("C*"), b.unpack("C*")) { |i,x,y| return i if x != y }
	end
end
pp MethodLookupTrie.new([['hello',1], ['helo',2], ['hi',3], ['thing',4], ['word',5], ['world',6]])

__END__
topnode:  <(1)node width>, *(<(1)char>, <(2) jump>)
subnode:  *(<(1) char>) <(1)nullbyte> <topnode>
leafnode: *(<(1) char>) <(1)nullbyte> <(1)node width> <(4) data>

topnode: 1+3n bytes (n = branches)
subnode: 1+m+3n bytes (m = skipchars)
leafnode: m+6 bytes

hello
helo
hi
thing
word
world

10 topnode:  (3)h(jump)t(jump)w(jump)
 8 subnode:  (null)(2)e(jump)i(jump)   # h...
 9 subnode:  l(null)(2)l(jump)o(jump)  # hel...
 8 leafnode: lo(null)(1)(data)         # hello
 7 leafnode: o(null)(1)(data)          # helo
 7 leafnode: hing(null)(1)(data)       # thing
10 subnode:  or(null)(2)d(jump)l(jump) # wor...
 7 leafnode: d(null)(1)(data)          # word
 8 leafnode: ld(null)(1)(data)         # world

total: 74 bytes (49 bytes for data + strings)

trie: (3)h(jump)t(jump)w(jump)(null)(2)e(jump)i(jump)l(null)(2)l(jump)o(jump)lo(null)(1)(data)o(null)(1)(data)hing(null)(1)(data)or(null)(2)d(jump)l(jump)d(null)(1)(data)ld(null)(1)(data)