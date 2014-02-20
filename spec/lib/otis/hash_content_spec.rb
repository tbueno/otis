require 'spec_helper'

describe Otis::HashContent do
  describe 'accessor generation' do
    let(:params) do {a: {b: {foo: 'bar'}}} end

    class ComplexClass < Otis::Model
      root_key to: [:a, :b]
      attribute :foo, String
    end

    it 'creates an array to the root key' do
      ComplexClass.new(params).path.should == [:a, :b]
    end

    it 'sets the root key' do
      ComplexClass.new(params).foo.should == 'bar'
    end
  end

  describe 'remaping root key name' do

    let(:params) do {a: {b: {foo: 'bar'}}} end

    class EvenMoreComplex < Otis::Model
      root_key to: [:a, :b], as: 'baz'
      attribute :baz, String
    end

    it 'response accordingly' do
      EvenMoreComplex.new(params).baz.should == {foo: 'bar'}
    end
  end
end