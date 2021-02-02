
module IpaMaker
  class Command

    require 'json'
    require 'ipamaker/command/configtool'
    require 'ipamaker/command/constclass'

    class SchemeName < Command

      def initialize(argv)
        super
      end

      self.summary = 'Setting SchemeName'

      self.description = <<-DESC
      Setting SchemeName
      DESC

      def run
        super
        tool = ConfigTool.new(ConstClass::SCHEMENAME_KEY)
        tool.create_file_not_exist
        print "Please Enter Scheme Name: "
        path = STDIN.gets.chomp
        tool.save_content(path)
      end
    end
  end
end
