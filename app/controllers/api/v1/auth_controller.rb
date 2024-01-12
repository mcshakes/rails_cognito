module Api
  module V1
    class AuthController < ApplicationController
      
      def sign_in
        user_object = {
          USERNAME: params[:email],
          PASSWORD: params[:password]
        }                
        
        begin
          @user = User.find_by( email: user_object[:USERNAME] )

          if @user
            response = aws_cognito_client.authenticate(user_object)
            handle_authentication_response(response)
          else
            render json: { type: 'error', message: 'no user' }
          end
          
        rescue => e
          handle_authentication_error(e)
        end
      end
    
      def sign_out
        if request.headers['Authorization']
          Cognito.sign_out(request.headers['Authorization'])
          resp = { type: 'success', message: 'now you are disconected' }
        else
          resp = { type: 'error', message: 'empty token' }
        end
        render json: resp
      end

      def register 
        puts "Incoming request params: #{params.inspect}"

        user_object = {
          USERNAME: params[:email],
          PASSWORD: params[:password]
        }
        
        user = User.new(
                email: params[:email],
                first_name: params[:first_name],
                last_name: params[:last_name],
                role: params[:role]
              )

        begin

          ActiveRecord::Base.transaction do
            user.save!
            aws_cognito_client.register_user(user_object)
          end          
          render json: { message: 'User registered successfully' }      

        rescue ActiveRecord::RecordInvalid => e
          render json: { error: e.message }, status: :unprocessable_entity
        rescue => e
          handle_authentication_error(e)
        end
      end
    
      private

      def aws_cognito_client
        @aws_cognito_client ||= Cognito.new
      end
        
      def handle_authentication_response(response)
        if response.authentication_result
          Rails.logger.info("User successfully logged in")
          render json: { success: true, authentication_result: response.authentication_result }
        else
          Rails.logger.error("Authentication failed: #{response}")
          render json: { success: false, error: 'Authentication failed' }, status: :unprocessable_entity
        end
      end
    
      def handle_authentication_error(error)
        Rails.logger.error("Authentication error: #{error.message}")
        render json: { success: false, error: error.message }, status: :unprocessable_entity
      end

    end
  end
end
