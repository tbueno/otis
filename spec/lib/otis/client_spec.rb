require 'spec_helper'

describe Otis::Client do

  class MyClient < Otis::Client
  end
  class ResponseClass; def initialize(string); end; end

  describe 'call' do
    let(:client)   { stub('soap client')}
    let(:response) { {my_call: 'response'}}

    before do
      client.stub_chain(:call, :body).and_return(response)
      Savon.stub(client: client)
    end

    it 'delegates the call the the client' do
      client.should_receive(:call).with(:my_call, {params: []})
      MyClient.new({my_call: ResponseClass}, mock).my_call(params: [])
    end
  end
end
