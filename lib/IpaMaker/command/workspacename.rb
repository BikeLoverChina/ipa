
module IpaMaker
  class Command

    require 'json'
    require 'ipamaker/command/configtool'
    require 'ipamaker/command/constclass'

    class WorkSpaceName < Command

      def initialize(argv)
        super
      end

      self.summary = 'Setting WorkSpaceName'

      self.description = <<-DESC
      Setting WorkSpaceName
      DESC

      def run
        super
        tool = ConfigTool.new(ConstClass::WORKSPACENAME_KEY)
        tool.create_file_not_exist
        print "Please Enter WorkSpaceName Name: "
        path = STDIN.gets.chomp
        tool.save_content(path.chomp)
      end
    end
  end
end
