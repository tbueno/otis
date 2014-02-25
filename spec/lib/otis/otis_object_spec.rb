require 'spec_helper'

describe Otis::Object do

  describe 'collection' do
    class Thing; end

    class TestClass
      include Otis::Object
      collection of: Thing, as: :things
    end

    let(:klass) { TestClass.new }

    it 'creates the get' do
      expect(klass).to respond_to(:things)
    end

    it 'holds a collection' do
      klass.things << Thing.new
      klass.things << Thing.new
      expect(klass.things.count).to eq(2)
    end

    describe 'tag attributes' do
      class TestAttributeClass < Otis::Model
        include Otis::Object
        tag_attributes :foo, :bar
      end

      describe 'dinamic method creation' do
        it 'reads from the hash removing @' do
          t = TestAttributeClass.new(:@foo => 'f', :@bar => 'b')
          t.foo.should == 'f'
          t.bar.should == 'b'
        end
      end
    end
  end
end