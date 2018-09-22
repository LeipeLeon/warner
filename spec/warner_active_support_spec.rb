require "spec_helper"
require 'active_support'

RSpec.describe 'Warner w/ ActiveSupport' do

  it "has a version number" do
    expect(Warner::VERSION).not_to be nil
  end

  context ".colored_warning" do

    it "displays the message on $stderr" do
      out = capture_stderr do
        Warner.colored_warning('warning!')
      end
      expect(out.string).to match(/^DEPRECATION WARNING/)
    end

  end

  context ".gem_version_warning" do

    it "displays the message on $stderr" do
      out = capture_stderr do
        Warner.gem_version_warning('warner', '0.0.1', 'warning!')
      end
      expect(out.string).to match(/DEPRECATION WARNING: \[gem:warner\] (.*) > 0\.0\.1 : warning!/)
    end

    it "no message if version is the same" do
      out = capture_stderr do
        Warner.gem_version_warning('warner', Warner::VERSION, 'warning!')
      end
      expect(out.string).not_to match(/DEPRECATION WARNING/)
    end

    it "no message if version is lower" do
      out = capture_stderr do
        Warner.gem_version_warning('warner', '9.9.1', 'warning!')
      end
      expect(out.string).not_to match(/DEPRECATION WARNING/)
    end

  end

  context ".rails_version_warning" do

    context "With Rails loaded" do

      before do
        stub_const 'Rails', Class.new
        Rails.class_eval { def self.version ; '1.2.3' ; end }
      end

      it "displays the message on $stderr" do
        out = capture_stderr do
          Warner.rails_version_warning('0.0.1', 'warning!')
        end
        expect(out.string).to match(/\[RAILS\] (.*) > 0\.0\.1 : warning!/)
      end

      it "no message if version is the same" do
        out = capture_stderr do
          Warner.rails_version_warning('1.2.3', 'warning!')
        end
        expect(out.string).not_to match(/\[RAILS\] (.*) > 0\.0\.1 : warning!/)
      end

      it "no message if version is lower" do
        out = capture_stderr do
          Warner.rails_version_warning('3.2.22', 'warning!')
        end
        expect(out.string).not_to match(/\[RAILS\] (.*) > 0\.0\.1 : warning!/)
      end

    end

    context "Without Rails" do
      it "raises an error that rails is not loaded" do
        expect {
          Warner.rails_version_warning('0.0.1', 'warning!')
        }.to raise_error(RuntimeError, 'Rails not loaded')
      end
    end

  end

  # context "stack trace" do
  #   ActiveSupport::Deprecation.debug = true
  # end

end
