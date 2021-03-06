module Jekyll
  module Converters
    class Markdown
      class KramdownParser
        def initialize(config)
          require 'kramdown'
          @config = config
        rescue LoadError
          STDERR.puts 'You are missing a library required for Markdown. Please run:'
          STDERR.puts '  $ [sudo] gem install kramdown'
          raise FatalException.new("Missing dependency: kramdown")
        end

        def convert(content)
          # Check for use of coderay
          if @config['kramdown']['use_coderay']
            %w[wrap line_numbers line_numbers_start tab_width bold_every css default_lang].each do |opt|
              key = "coderay_#{opt}"
              @config['kramdown'][key.to_sym] = @config['kramdown']['coderay'][key] unless @config['kramdown'].has_key?(key)
            end
          end

          Kramdown::Document.new(content, @config["kramdown"].symbolize_keys).to_html
        end

      end
    end
  end
end
