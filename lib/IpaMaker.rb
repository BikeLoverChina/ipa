# frozen_string_literal: true

require_relative "IpaMaker/version"

module IpaMaker
  class Error < StandardError; end

  autoload :Command, 'ipamaker/command'
end
