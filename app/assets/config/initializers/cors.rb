Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'  # Allow requests from any origin (change in production)
    resource '*', 
      headers: :any, 
      methods: [:get, :post, :put, :patch, :delete, :options], 
      credentials: false
  end
end
rails restart
