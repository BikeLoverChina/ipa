
module IpaMaker
  class Command

    require 'json'
    require 'ipamaker/command/configtool'
    require 'ipamaker/command/constclass'

    class AppName < Command

      def initialize(argv)
        super
      end

      self.summary = 'Setting AppName'

      self.description = <<-DESC
      Setting AppName
      DESC

      def run
        super
        tool = ConfigTool.new(ConstClass::APPNAME_KEY)
        tool.create_file_not_exist
        print "Please Enter AppName: "
        path = STDIN.gets.chomp
        tool.save_content(path.chomp)
      end
    end
  end
end
