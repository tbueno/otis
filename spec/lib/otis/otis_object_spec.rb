require 'spec_helper'

describe Otis::Object do

  describe 'collection' do
    class Thing < Otis::Model
      attribute :a
    end

    class TestClass
      include Otis::Object
      collection of: Thing, as: :things
    end

    let(:klass) { TestClass.new }

    it 'creates the get' do
      expect(klass).to respond_to(:things)
    end

    it 'holds a collection' do
      klass = TestClass.new
      klass.things << Thing.new
      klass.things << Thing.new
      expect(klass.things.count).to eq(2)
    end

    it 'transforms correctly the collection' do
      klass = TestClass.new(:things => [{a: 'foo'},  {b: 'bar'}])
      expect(klass.things.count).to eq(2)
      expect(klass.things.first.a).to eq('foo')
    end

    context 'when element is no a collection' do
      subject {TestClass.new(:things => {a: 'foo'}).things}
      it 'makes a new collection containing the element' do
        expect(subject.count).to eq(1)
        expect(subject.first.a).to eq('foo')
      end
    end

  end

  describe 'tag attributes' do
    class TestAttributeClass < Otis::Model
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