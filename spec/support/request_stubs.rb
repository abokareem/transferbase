# frozen_string_literal: true

module RequestStubs
  def stub_200(method = :get, uri = url)
    stub_request(method, uri).to_return(status: 200, body: successful_response_body)
  end

  def stub_422(method, uri)
    stub_request(method, uri).to_return(status: 422, exception: RestClient::ExceptionWithResponse)
  end

  def successful_response_body
    {
      'rates' => {
        'EUR' => 0.9004141905,
        'GBP' => 0.823924005
      },
      'base' => 'USD',
      'date' => '2019-08-02'
    }.to_json
  end

  def default_uri
    'https://api.exchangeratesapi.io/latest?base=USD&symbols=EUR,GBP'
  end
end
