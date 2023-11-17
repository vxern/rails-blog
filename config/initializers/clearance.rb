Clearance.configure do |config|
  config.routes = false
  config.mailer_sender = "notifications@example.com"
  config.password_strategy = Clearance::PasswordStrategies::Argon2
  config.rotate_csrf_on_sign_in = true
end
