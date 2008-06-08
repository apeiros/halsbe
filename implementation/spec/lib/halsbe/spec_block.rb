# bacon_helper sets up the environment
require File.dirname(__FILE__)+'/../../../bacon_helper'
require 'halsbe/block'

describe 'A block without arguments' do
	before do
		@block  = Block.new(nil)
	end

	it 'should have an arity of 0' do
		@block.arity.should.equal 0
	end
	
	its 'arguments attribute should be empty' do
		@block.arguments.should.be.empty
	end
	
	it 'should not have compact_args' do
		@block.compact_args.should.be.conditionally_false
	end
	
	it 'should not have compact_kwargs' do
		@block.compact_kwargs.should.be.conditionally_false
	end
end

