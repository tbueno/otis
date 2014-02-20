require 'spec_helper'

describe Otis::HttpClient do

  class MyHttpClient < Otis::HttpClient
  end
  class ResponseClass; def initialize(string); end; end

  let(:map) do
    Otis::Map.new({
      :op1 => ResponseClass,
      :op2 => double
    })
  end

  describe 'operations' do
    it 'maps the allowed entrypoints' do
      expect(described_class.new(map, 'url').operations).to eq([:op1, :op2])
    end
  end

  describe 'create client' do
    let(:url) { 'http://api.site.com' }

    it 'instantiate a faraday client with endpoint url' do
      expect(Faraday).to receive(:new).with(url: url)
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

    let(:faraday)  { double(get: response)                                  }
    let(:url)      { 'api/v1'                                               }
    let(:params)   {                         { param1: 'foo', param2: 'bar' }                 }
    let(:response) { double(body: "          { \"my_call\": \"response\"    } ", status: 200) }
    let(:routes)   { Otis::Map.new(          { my_call: ResponseClass       } )               }

    before { Otis::HttpClient.any_instance.stub(create_client: faraday)}

    it 'forwards the call to the client' do
      expect(faraday).to receive(:get).with(url, params, {'Content-Type' => 'application/json'})
      MyHttpClient.new(routes, 'url').my_call(url, params)
    end

    it 'returns response object' do
      expect(MyHttpClient.new(routes, 'url').my_call(url, params))
        .to be_a(ResponseClass)
    end

    it 'passes the parsed response to response object' do
      ResponseClass.should_receive(:new).with({'my_call' => 'response'})
      MyHttpClient.new(routes, 'url').my_call(url, params)
    end
  end

end
