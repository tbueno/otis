require 'spec_helper'

describe Otis::Hooks do


  class TestClient < Otis::Client
      filter :my_method, with: :my_filter
      def initialize(routes); @routes = routes; end
      def my_filter(content); content[:foo].upcase! ;end
      def call(action, url, options)
        {foo: 'bar'}
      end
    end

  describe 'filter' do

    let(:response) { double }

    it 'executes filters with results of method' do
      object = TestClient.new(my_method: response)
      expect(object.my_method(double, double)).to eq('BAR')
    end
  end

end