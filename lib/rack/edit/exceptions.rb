class Rack::Edit::Exceptions

  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  rescue LoadError, StandardError, SyntaxError => exception
    env["rack.errors"].puts "#{exception.class}: #{exception.message}"
    env["rack.errors"].puts exception.backtrace.map { |l| "  %s" % l }
    env["rack.errors"].flush

    @request = Rack::Request.new(env)
    @exception = exception
    [500, headers, body]
  end

  def headers
    { "Content-Type" => "text/html",
      "Content-Length" => content_length }
  end

  def content_length
    "%s" % body.size
  end

  def body
    [ '<pre>',
      "#{@exception.class}: #{@exception.message}",
      @exception.backtrace.map { |l| "  %s" % link_to(l) }.join("\n"),
      '</pre>',
    ].flatten.join
  end

  def link_to line
    "<a href='mvim://open?url=file://%s'>%s</a>" % [file(line), line]
    "<a href='txmt://open?url=file://%s'>%s</a>" % [file(line), line]
  end

  def file line
    File.expand_path(line.split(":").shift)
  end

end
