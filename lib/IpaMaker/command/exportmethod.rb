
module IpaMaker
  class Command

    require 'json'
    require 'ipamaker/command/configtool'

    class ExportMethod < Command

      def initialize(argv)
        super
      end

      self.summary = 'Setting ExportMethod app-store, package, ad-hoc, enterprise, development'

      self.description = <<-DESC
      Setting ExportMethod app-store, package, ad-hoc, enterprise, development
      DESC

      def run
        super
        tool = ConfigTool.new("exportmethod_name_key")
        tool.create_file_not_exist
        print "Please Enter ExportMethod Name: "
        path = STDIN.gets.chomp
        tool.save_content(path.chomp)
      end
    end
  end
end
