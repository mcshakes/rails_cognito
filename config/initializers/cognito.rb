class Cognito
  attr_reader :client

  def initialize
    @aws_credentials = Rails.application.credentials.aws

    @client = @client || Aws::CognitoIdentityProvider::Client.new(
      region: @aws_credentials.AWS_COGNITO_REGION,
      access_key_id: @aws_credentials.AWS_ACCESS_KEY,
      secret_access_key: @aws_credentials.AWS_SECRET_KEY
    )
  end

  def authenticate(user_params)
    user_object = {}
    
    user_object[:USERNAME] = user_params[:USERNAME]
    user_object[:PASSWORD] = user_params[:PASSWORD]

    auth_object = {
      user_pool_id: @aws_credentials.AWS_COGNITO_POOL_ID,
      client_id: @aws_credentials.AWS_COGNITO_APP_CLIENT_ID,
      auth_flow: 'ADMIN_NO_SRP_AUTH',
      auth_parameters: user_object
    }

    client.admin_initiate_auth(auth_object)
  end

  def register_user(user_params)
    auth_object = {
      client_id: @aws_credentials.AWS_COGNITO_APP_CLIENT_ID,
      username: user_params[:USERNAME] || "",
      password: user_params[:PASSWORD] || "",
      user_attributes: [
        {
          name: "email",
          value: user_params[:USERNAME] || "",
        }
      ]
    }

    client.sign_up(auth_object)
  end

  def sign_out(access_token)
    client.global_sign_out(access_token: access_token)
  end
end