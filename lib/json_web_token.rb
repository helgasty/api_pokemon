class JsonWebToken
  class << self
    JWT_SECRET = ENV["JWT_SECRET_KEY"]

    def encode(payload, exp = (Rails.env.test?) ? 10.seconds.from_now : 2.minute.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, JWT_SECRET)
    end

    def decode(token)
      body = JWT.decode(token, JWT_SECRET)[0]
      HashWithIndifferentAccess.new body
    rescue JWT::ExpiredSignature, JWT::VerificationError
      return 403
    rescue JWT::DecodeError, JWT::VerificationError
      return 500
    end
  end
end