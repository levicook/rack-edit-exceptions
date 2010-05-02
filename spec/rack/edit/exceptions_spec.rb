require 'spec_helper'

describe Rack::Edit::Exceptions do
  let(:app) { lambda { fail 'Oooo nooo!' } }
  let(:req) { Rack::MockRequest.new(middleware) }
  let(:res) { req.get('/', :lint => true) }

  let(:middleware) { Rack::Edit::Exceptions.new(app) }

  specify { expect { app.call }.to raise_error }
  specify { expect { res }.to_not raise_error }

  describe 'response to RuntimeError' do
    subject { res }
    its(:status)         { should == 500 }
		its(:content_length) { should > 0 }
		its(:content_type)   { should == 'text/html' }

    context :headers do
      subject { res.headers }
      its(:length) { should == 2 }
      its(:keys)   { should include('Content-Length') }
      its(:keys)   { should include('Content-Type')   }
    end
  end

end
