module IpaMaker
  class Command

    require 'ipamaker/command/configtool'
    require 'ipamaker/command/constclass'
    require 'ipamaker/command/buildtool'

    class PrintConfig < Command

      def initialize(argv)
        super
      end

      self.summary = 'Print Current Config'

      self.description = <<-DESC
      Print Current Config
      DESC

      def run
        super
        workspace_path = BuildTool.cls_common_get_fromjson(ConstClass::WORKSPACENAME_KEY, ConstClass::DEFWORKSPACENAME_KEY)
        scheme = BuildTool.cls_common_get_fromjson(ConstClass::SCHEMENAME_KEY, ConstClass::DEFSCHEMENAME_KEY)
        configuration = BuildTool.cls_common_get_fromjson(ConstClass::CONFIGURATIONNAME_KEY, ConstClass::DEFCONFIGURATIONNAME_KEY)
        archive_path = BuildTool.cls_common_get_fromjson(ConstClass::ARCHIVEPATH_KEY, ConstClass::DEFARCHIVEPATH_KEY)
        export_method = BuildTool.cls_common_get_fromjson(ConstClass::EXPORTMETHOD_KEY, ConstClass::DEFEXPORTMETHOD_KEY)
        output_path = BuildTool.cls_common_get_fromjson(ConstClass::OUTPUTPATH_KEY, ConstClass::DEFOUTPUTPATH_KEY)
        ipa_name = BuildTool.cls_common_get_fromjson(ConstClass::APPNAME_KEY, ConstClass::DEFAPPNAME_KEY)
        user_key = BuildTool.cls_common_get_fromjson(ConstClass::PGYERUSER_KEY, ConstClass::DEFPGYERUSER_KEY)
        api_key = BuildTool.cls_common_get_fromjson(ConstClass::PGYERAIP_KEY, ConstClass::DEFPGYERAIP_KEY)
        ignoredesc = BuildTool.cls_common_get_value(ConstClass::PGYERIGNOREDESC_KEY)

        puts "workspace_path: #{workspace_path}"
        puts "scheme: #{scheme}"
        puts "configuration: #{configuration}"
        puts "archive_path: #{archive_path}"
        puts "export_method: #{export_method}"
        puts "output_path: #{output_path}"
        puts "ipa_name: #{ipa_name}"
        puts "user_key: #{user_key}"
        puts "api_key: #{api_key}"
        puts "ignoredesc: #{ignoredesc}"
      end
    end
  end
end


