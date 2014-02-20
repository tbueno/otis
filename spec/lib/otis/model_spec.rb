require 'spec_helper'

describe Otis::Model do

  describe 'initialization' do
    class SimpleClass < Otis::Model
      attribute :my_key, String
    end

    describe 'with attributes' do
      it 'creates the attribute getter' do
        expect(SimpleClass.new({my_key: 'value'}).my_key).to eql('value')
      end
    end
  end
end
