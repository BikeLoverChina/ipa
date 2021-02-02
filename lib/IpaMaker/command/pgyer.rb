module IpaMaker
  class Command

    require 'ipamaker/command/configtool'
    require 'ipamaker/command/constclass'

    class Pgyer < Command

      def initialize(argv)
        super
      end

      self.summary = 'Setting Pgyer API Key、User Key'

      self.description = <<-DESC
      Setting Pgyer API Key、User Key
      DESC

      def run
        super
        ConfigTool.cls_create_file_not_exist

        print "Ignore Pgyer Desc: 0/1 ? "
        ignore = STDIN.gets.chomp
        ConfigTool.cls_save_content(ConstClass::PGYERIGNOREDESC_KEY, ignore)

        print "Please Enter API Key: "
        apikey = STDIN.gets.chomp
        if apikey.length == 0
          return
        end
        ConfigTool.cls_save_content(ConstClass::PGYERAIP_KEY, apikey)
        print "Please Enter User Key: "
        userkey = STDIN.gets.chomp
        if userkey.length == 0
          return
        end
        ConfigTool.cls_save_content(ConstClass::PGYERUSER_KEY, userkey)
      end
    end
  end
end

