require 'spec_helper'

describe Otis::Model do
  class TestClass < Otis::Model
    attribute :foo, String
  end

  describe 'initialization' do
    describe 'with attributes' do
      it 'creates the attribute getter' do
        expect(TestClass.new(foo: 'bar').foo).to eql('bar')
      end
    end
  end
end
