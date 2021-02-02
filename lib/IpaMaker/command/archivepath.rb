
module IpaMaker
  class Command

    require 'json'
    require 'ipamaker/command/configtool'
    require 'ipamaker/command/constclass'

    class ArchivePath < Command

      def initialize(argv)
        super
      end

      self.summary = 'Setting ArchivePath'

      self.description = <<-DESC
      Setting ArchivePath
      DESC

      def run
        super
        tool = ConfigTool.new(ConstClass::ARCHIVEPATH_KEY)
        tool.create_file_not_exist
        print "Please Enter ArchivePath: "
        path = STDIN.gets.chomp
        tool.save_content(path.chomp)
      end
    end
  end
end
