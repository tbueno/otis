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
  end
end