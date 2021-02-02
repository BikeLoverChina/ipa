module IpaMaker
  require 'claide'
  require 'colored2'

  class Command < CLAide::Command

    require 'ipamaker/command/archivepath'
    require 'ipamaker/command/buildipa'
    require 'ipamaker/command/schemename'
    require 'ipamaker/command/workspacename'
    require 'ipamaker/command/configuration'
    require 'ipamaker/command/exportmethod'
    require 'ipamaker/command/pgyer'
    require 'ipamaker/command/printconfig'

    self.abstract_command = true

    self.description = '0.0.1 Ipa Maker Tool.'

    self.command = 'ipa'

    def self.options
      [
          ['--no-options', 'Not support options']
      ].concat(super)
    end

    def initialize(argv)
      super
    end

    def run
    end
  end
end
