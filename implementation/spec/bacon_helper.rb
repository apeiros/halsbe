require File.expand_path(File.dirname(__FILE__)+'/..') + '/spec_env'
require 'rubygems'
require 'bacon'
require 'flexmock'

base = File.expand_path(File.dirname(__FILE__)+'/..')
$LOAD_PATH.unshift(base+'/lib') unless $LOAD_PATH.include?(base+'/lib')
$LOAD_PATH.unshift(base+'/spec') unless $LOAD_PATH.include?(base+'/spec')

include FlexMock::MockContainer

Test::Unit.run = false  if defined? Test::Unit

module Bacon
  class Context
    def it(description, &block)
      return  unless description =~ RestrictName
      block ||= proc { should.flunk "not implemented" }
      Counter[:specifications] += 1
      run_requirement description, block
    end
    
    alias its it
  end
end

class Object
	# { 1 => 'a', 5 => 'b' }.keys.should.equal_unordered [1, 5]
	def equal_unordered(expected)
		lambda { |actual|
			seen = Hash.new(0)
			expected.each { |e| seen[e] += 1 }
			actual.each { |e| seen[e] -= 1 }
			seen.invert.keys == [0]
		}
	end
	
	# (3..5).should.iterate [3, 4, 5]
	def iterate(expected, meth=:each, *args)
		lambda { |obj|
			t = []
			obj.__send__(meth, *args) { |v| t << v }
			t == expected
		}
	end
	
	# { 1 => 'a', 5 => 'b' }.keys.should.iterate_unoredered [1, 5]
	def iterate_unordered(expected, meth=:each, *args)
		lambda { |obj|
			seen = Hash.new(0)
			expected.each { |e| seen[e] += 1 }
			obj.__send__(meth, *args) { |e| seen[e] -= 1 }
			seen.invert.keys == [0]
		}
	end

	# Everything but nil and false will satisfy this
	# "foo".should.be.conditionally_true
	def conditionally_true
		!!self
	end
	
	# Only nil and false will satisfy this
	# nil.should.be.conditionally_false
	def conditionally_false
		!self
	end
end
