require "spec_helper"

RSpec.describe Warner do

  before do
    allow(Object).to receive(:const_defined?).with('ActiveSupport').and_return(false)
    allow(Object).to receive(:const_defined?).with('Rails').and_return(false)
  end

  it "has a version number" do
    expect(Warner::VERSION).not_to be nil
  end

  context ".colored_warning" do

    it "displays the message on $stderr" do
      out = capture_stderr do
        Warner.colored_warning('warning!')
      end
      expect(out.string).to eq("\e\[41;37;1m[DEPRECATION WARNING]: warning!\e\[0m\n")
    end

  end

  context ".gem_version_warning" do

    it "displays the message on $stderr" do
      out = capture_stderr do
        Warner.gem_version_warning('warner', '0.0.1', 'warning!')
      end
      expect(out.string).to match(/\[DEPRECATION WARNING\]: \[gem:warner\] 1.0.2 > 0.0.1 : warning!/)
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

    # context "With Rails loaded" is not applicable here
    # b/c when rails is loaded, ActiveSupport is loaded as well

    context "Without Rails" do
      it "raises an error that rails is not loaded" do
        expect {
          Warner.rails_version_warning('0.0.1', 'warning!')
        }.to raise_error(RuntimeError, 'Rails not loaded')
      end
    end

  end

end
