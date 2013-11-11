require 'spec_helper'

describe Otis::HttpClient do

  class MyHttpClient < Otis::HttpClient
  end
  class ResponseClass; def initialize(string); end; end

  #TODO: pass the map object instead of the routes hash
  let(:map) do
    Otis::Map.new({
      :op1 => ResponseClass,
      :op2 => double

    }).routes
  end

  describe 'operations' do
    it 'maps the allowed entrypoints' do
      expect(described_class.new(map, 'url').operations).to eq([:op1, :op2])
    end
  end

  describe 'create client' do
    let(:url) { 'http://api.site.com' }

    it 'instantiate a faraday client with endpoint url' do
      Faraday.should_receive(:new).with(url: url)
      described_class.new(map, url)
    end

    describe 'default options' do

      after :each do described_class.new(map, url) end

      it 'sets the request type' do
        Faraday::Connection.any_instance.should_receive(:request).with(:url_encoded)
      end

      it 'sets response output' do
        Faraday::Connection.any_instance.should_receive(:response).with(:logger)
      end

      it 'sets adapter' do
        Faraday::Connection.any_instance.should_receive(:adapter).with(Faraday.default_adapter)
      end
    end
  end

  describe 'call' do
    let(:faraday)   { double }
    let(:response) { {my_call: 'response'}}

    before { Otis::HttpClient.any_instance.stub(create_client: faraday)}

    it 'forwards the call to the client' do
      faraday.should_receive(:get).with("api/v1/my_call", {param1: 'foo', param2: 'bar'})
      MyHttpClient.new({my_call: ResponseClass}, 'url').my_call('api/v1', {param1: 'foo', param2: 'bar'})
    end
  end

  # describe 'call' do
  #   let(:client)   { stub('soap client')}
  #   let(:response) { {my_call: 'response'}}

  #   before do
  #     client.stub_chain(:call, :body).and_return(response)
  #     Savon.stub(client: client)
  #   end

  #   it 'delegates the call the the client' do
  #     client.should_receive(:call).with(:my_call, {params: []})
  #     MyClient.new({my_call: ResponseClass}, mock).my_call(params: [])
  #   end
  # end
end
