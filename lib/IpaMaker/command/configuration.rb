
module IpaMaker
  class Command

    require 'json'
    require 'ipamaker/command/configtool'
    require 'ipamaker/command/constclass'

    class Configuration < Command

      def initialize(argv)
        super
      end

      self.summary = 'Setting Configuration Debug, Release'

      self.description = <<-DESC
      Setting Configuration Debug, Release
      DESC

      def run
        super
        tool = ConfigTool.new(ConstClass::CONFIGURATIONNAME_KEY)
        tool.create_file_not_exist
        print "Please Enter Configuration Name: "
        path = STDIN.gets.chomp
        tool.save_content(path.chomp)
      end
    end
  end
end
