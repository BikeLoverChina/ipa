
module IpaMaker
  class Command

    require 'ipamaker/command/buildtool'

    class BuildIpa < Command
      # self.abstract_command = true

      self.summary = 'Build Ipa'

      self.description = <<-DESC
      Build Ipa
      DESC

      def run
        super
        BuildTool.new.startBuild
      end

    end
  end
end
