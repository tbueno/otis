require 'spec_helper'

describe Otis::SoapClient do

  class MySoapClient < Otis::SoapClient
  end
  class ResponseClass; def initialize(response); end; end

  let(:client)   { double(operations: [:op1, :op2])}
  let(:routes) { Otis::Map.new({my_call: ResponseClass}) }

  before { Savon.stub(client: client) }

  describe 'operations' do
    it 'maps the allowed from client' do
      expect(described_class.new(routes, double).operations).to eq([:op1, :op2])
    end
  end

  describe 'call' do
    let(:response) { {my_call: 'response'}}

    before { client.stub_chain(:call, :body).and_return(response) }

    it 'delegates the call the the client' do
      client.should_receive(:call).with(:my_call, {params: []})
      MySoapClient.new(routes, double).my_call(params: [])
    end

    it 'returns response object' do
      MySoapClient.new(routes, double).my_call(params: []).should be_a(ResponseClass)
    end

    it 'passes the attributes to response object' do
      ResponseClass.should_receive(:new).with(response)
      MySoapClient.new(routes, double).my_call(params: [])
    end
  end
end
