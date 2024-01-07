describe 'DNS Records' do
  describe 'POST /api/v1/dns_records' do
    it 'creates a DNS record with associated hostnames' do
      params = {
        dns_record: {
          ip: '1.1.1.1',
          hostnames_attributes: [
            { name: 'lorem.com' },
            { name: 'ipsum.com' },
            { name: 'dolor.com' }
          ]
        }
      }

      post '/api/v1/dns_records', params: params

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include('id')
    end
  end

  describe 'GET /api/v1/dns_records' do
    before do
      create(:dns_record, ip: '1.1.1.1', hostnames: [create(:hostname, name: 'lorem.com')])
      create(:dns_record, ip: '2.2.2.2', hostnames: [create(:hostname, name: 'ipsum.com')])
      create(:dns_record, ip: '3.3.3.3', hostnames: [create(:hostname, name: 'dolor.com')])
    end

    it 'returns DNS records and their hostnames' do
      params = {
        included_hostnames: ['lorem.com'],
        excluded_hostnames: ['ipsum.com'],
        page: 1
      }

      get '/api/v1/dns_records', params: params

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)
      expect(body).to include('total_records', 'dns_records', 'result_records')

      expect(body['dns_records'].count).to eq(1)
      expect(body['result_records'].count).to eq(1)
      expect(body['result_records'].first['hostname']).to eq('lorem.com')
    end
  end
end
