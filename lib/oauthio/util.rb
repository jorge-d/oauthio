module Oauthio
  class Util
    def self.log_debug msg
      return unless !Oauthio.logger.nil? || (!Oauthio.log_level.nil? && Oauthio.log_level <= Oauthio::LEVEL_DEBUG)
      log_internal(msg, color: :blue, level: Oauthio::LEVEL_DEBUG, logger: Oauthio.logger, out: $stdout)
    end

    def self.log_info msg
      return unless !Oauthio.logger.nil? || (!Oauthio.log_level.nil? && Oauthio.log_level <= Oauthio::LEVEL_INFO)
      log_internal(msg, color: :cyan, level: Oauthio::LEVEL_INFO, logger: Oauthio.logger, out: $stdout)
    end

    def self.log_error msg
      return unless !Oauthio.logger.nil? || (!Oauthio.log_level.nil? && Oauthio.log_level <= Oauthio::LEVEL_ERROR)
      log_internal(msg, color: :cyan, level: Oauthio::LEVEL_ERROR, logger: Oauthio.logger, out: $stderr)
    end

    private

    def self.log_internal(message, data: {}, color:, level:, logger:, out:)
      # TODO : infer data_str from data
      data_str = ''

      if !logger.nil?
        logger.log(level, format("message=%s %s", message, data_str))
      elsif out.isatty
        out.puts format("%s %s %s", colorize(level_name(level)[0, 4].upcase, color, out.isatty), message, data_str)
      else
        out.puts format("message=%s level=%s %s", message, level_name(level), data_str)
      end
    end

    def self.level_name(level)
      case level
      when LEVEL_DEBUG then "debug"
      when LEVEL_ERROR then "error"
      when LEVEL_INFO  then "info"
      else level
      end
    end


    COLOR_CODES = {
      black:   0, light_black:   60,
      red:     1, light_red:     61,
      green:   2, light_green:   62,
      yellow:  3, light_yellow:  63,
      blue:    4, light_blue:    64,
      magenta: 5, light_magenta: 65,
      cyan:    6, light_cyan:    66,
      white:   7, light_white:   67,
      default: 9,
    }.freeze

    def self.colorize(val, color, isatty)
      return val unless isatty

      mode = 0 # default
      foreground = 30 + COLOR_CODES.fetch(color)
      background = 40 + COLOR_CODES.fetch(:default)

      "\033[#{mode};#{foreground};#{background}m#{val}\033[0m"
    end
  end
end
