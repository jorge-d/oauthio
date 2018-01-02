require 'spec_helper'

RSpec.describe Oauthio do
  describe "log" do
    around(:each) do |example|
      @old_log_level = Oauthio.log_level
      Oauthio.log_level = nil

      @old_stderr = $stderr
      $stderr = StringIO.new

      @old_stdout = $stdout
      $stdout = StringIO.new

      example.run

      Oauthio.log_level = @old_log_level
      $stderr = @old_stderr
      $stdout = @old_stdout
    end

    context ".log_debug" do
      it "not log if logging is disabled" do
        Oauthio::Util.log_debug("foo")
        expect("").to eq $stdout.string
      end

      it "log if level set to debug" do
        Oauthio.log_level = Oauthio::LEVEL_DEBUG
        Oauthio::Util.log_debug("foo")
        expect("message=foo level=debug \n").to eq $stdout.string
      end

      it "not log if level set to error" do
        Oauthio.log_level = Oauthio::LEVEL_ERROR
        Oauthio::Util.log_debug("foo")
        expect("").to eq $stdout.string
      end

      it "not log if level set to info" do
        Oauthio.log_level = Oauthio::LEVEL_INFO
        Oauthio::Util.log_debug("foo")
        expect("").to eq $stdout.string
      end
    end

    context ".log_error" do
      it "not log if logging is disabled" do
        Oauthio::Util.log_error("foo")
        expect("").to eq $stdout.string
      end

      it "log if level set to debug" do
        Oauthio.log_level = Oauthio::LEVEL_DEBUG
        Oauthio::Util.log_error("foo")
        expect("message=foo level=error \n").to eq $stderr.string
      end

      it "log if level set to error" do
        Oauthio.log_level = Oauthio::LEVEL_ERROR
        Oauthio::Util.log_error("foo")
        expect("message=foo level=error \n").to eq $stderr.string
      end

      it "log if level set to info" do
        Oauthio.log_level = Oauthio::LEVEL_INFO
        Oauthio::Util.log_error("foo")
        expect("message=foo level=error \n").to eq $stderr.string
      end
    end

    context ".log_info" do
      it "not log if logging is disabled" do
        Oauthio::Util.log_info("foo")
        expect("").to eq $stdout.string
      end

      it "log if level set to debug" do
        Oauthio.log_level = Oauthio::LEVEL_DEBUG
        Oauthio::Util.log_info("foo")
        expect("message=foo level=info \n").to eq $stdout.string
      end

      it "not log if level set to error" do
        Oauthio.log_level = Oauthio::LEVEL_ERROR
        Oauthio::Util.log_debug("foo")
        expect("").to eq $stdout.string
      end

      it "log if level set to info" do
        Oauthio.log_level = Oauthio::LEVEL_INFO
        Oauthio::Util.log_info("foo")
        expect("message=foo level=info \n").to eq $stdout.string
      end
    end
  end

  context ".log_* with a logger" do
     before do
      @out = StringIO.new
      logger = ::Logger.new(@out)

      # Set a really simple formatter to make matching output as easy aspossible
      logger.formatter = proc { |_, _, _, message| message }

      Oauthio.logger = logger
    end

    context ".log_debug" do
      it "log to the logger" do
        Oauthio::Util.log_debug("foo")
        expect("message=foo ").to eq @out.string
      end
    end

    context ".log_error" do
      it "log to the logger" do
        Oauthio::Util.log_error("foo")
        expect("message=foo ").to eq @out.string
      end
    end

    context ".log_info" do
      it "log to the logger" do
        Oauthio::Util.log_info("foo")
        expect("message=foo ").to eq @out.string
      end
    end
  end
end
