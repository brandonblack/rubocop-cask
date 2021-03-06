require 'rubygems'

module RuboCop
  module Cask
    # Version information for the Cask RuboCop plugin.
    module Version
      STRING = '0.12.0'.freeze

      def self.gem_version
        Gem::Version.new(STRING)
      end
    end
  end
end
