module CustomValidation
  extend ActiveSupport::Concern

  def validate_params_q(q)
    parsed = CGI::parse(q)
    new_hash = {}
    parsed.each { |key, value| new_hash[key] = value.first }
    new_hash
  end
end