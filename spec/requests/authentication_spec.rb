require "rails_helper"

RSpec.describe "Authentication", type: :request do
  describe "POST /sign_in" do
    before :all do
      post api_v1_auth_sign_in_path, 
        params: "{\"email\": \"testuser2@gmail.com\", \"password\": \"Pa$$w0rd\"}", 
        headers: {"Content-Type" => "application/json"}

      @response = response
      @response_json = JSON.parse(response.body)
    end

    it 'returns a JSON response with the correct keys' do
      expected_keys = [
        'success',
        'authentication_result'
      ]
  
      expect(@response_json.keys).to match_array(expected_keys)
    end
  
    it 'returns a JSON response with the correct authentication keys' do
      expected_authentication_keys = [
        'access_token',
        'expires_in',
        'token_type',
        'refresh_token',
        'id_token'
      ]
  
      expect(@response_json['authentication_result'].keys).to match_array(expected_authentication_keys)
    end
  
    it 'returns a JSON response with boolean success value' do
      expect(@response_json['success']).to be_in([true, false])
    end
  
    it 'returns a JSON response with string values for authentication attributes' do
      authentication_result = @response_json['authentication_result']
  
      expect(authentication_result['access_token']).to be_a(String)
      expect(authentication_result['token_type']).to be_a(String)
      expect(authentication_result['refresh_token']).to be_a(String)
      expect(authentication_result['id_token']).to be_a(String)
    end
  
    it 'returns a JSON response with an integer value for expires_in' do
      authentication_result = @response_json['authentication_result']
      expect(authentication_result['expires_in']).to be_a(Integer)
    end
    
    it "returns HTTP success" do      
      expect(@response).to have_http_status(:ok)    
    end
  end
end