# vim:set ft=ruby
require 'rubygems' if RUBY_VERSION < '1.9'

begin
  require 'hirb'
  require 'hirb-unicode'
rescue LoadError
  # Missing goodies, bummer
end

if defined? Hirb
  # Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |output, value|
        Hirb::View.view_or_page_output(value) || @old_print.call(output, value)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
end

# awesome_print
require 'awesome_print'
Pry.print = proc{|output,value| output.puts value.ai }

Pry.config.color = true
