require 'spec_helper'

describe "autoloading" do
	specify { expect { Rack::Edit }.to_not raise_error }
	specify { expect { Rack::Edit::Exceptions }.to_not raise_error }
	specify { expect { Rack::Edit::Mate }.to_not raise_error }
	specify { expect { Rack::Edit::Mvim }.to_not raise_error }
end
