def authenticate!
  # Extract <token> from the 'Bearer <token>' value of the Authorization header
  supplied_token = String(request.env['HTTP_AUTHORIZATION']).slice(7..-1)

  @auth_payload, @auth_header = verify(supplied_token)
rescue JWT::DecodeError => e
  raise(ExceptionHandler::InvalidToken, ("Invalid token: #{e.message}")) 
end

private

def verify(token)
  JWT.decode(token, nil,
	     true, # Verify the signature of this token
	     algorithm: 'RS256',
             iss: 'https://profound-confusion.auth0.com/',
	     verify_iss: true,
	     # auth0_api_audience is the identifier for the API set up in the Auth0 dashboard
             aud: 'https://profoundconfusion.com/id',
	     verify_aud: true) do |header|
    jwks_hash[header['kid']]
  end
end

def self.jwks_hash
  jwks_raw = Net::HTTP.get URI("https://profound-confusion.auth0.com/.well-known/jwks.json")
  jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
  Hash[
    jwks_keys
    .map do |k|
      [
	k['kid'],
	OpenSSL::X509::Certificate.new(
	  Base64.decode64(k['x5c'].first)
	).public_key
      ]
    end
  ]
end
