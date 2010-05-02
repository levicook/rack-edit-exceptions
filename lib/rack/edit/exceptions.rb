class Rack::Edit::Exceptions

  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  rescue LoadError, StandardError, SyntaxError => exception
    env["rack.errors"].puts "#{exception.class}: #{exception.message}"
    env["rack.errors"].puts exception.backtrace.map { |l| "\t" + l }
    env["rack.errors"].flush

    @request = Rack::Request.new(env)
    @exception = exception
    [500, headers, self]
  end

  def headers
    { "Content-Type" => "text/html",
      "Content-Length" => content_length }
  end

  def content_length
    '0'
  end

  def each
    []
  end
end
