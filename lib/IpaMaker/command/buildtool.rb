class BuildTool

  require 'ipamaker/command/constclass'

  def startBuild
    puts "1.开始检查工程文件"

    if !check_workspace_exist
      puts "工程文件不存在"
      return false
    end

    puts "2.初始化默认配置"
    init_def_config
    puts "3.开始打包"
    begin_archive_ipa
  end

  def check_workspace_exist
    arr = Dir.glob("*.xcworkspace")
    if arr.length > 0
      arr << Dir.glob("*.xcodeproj")
    else
      arr = Dir.glob("*.xcodeproj")
    end
    return (arr.length > 0 ? true  : false)
  end

  def begin_archive_ipa
    workspace_path = common_get_fromjson(ConstClass::WORKSPACENAME_KEY, ConstClass::DEFWORKSPACENAME_KEY)
    scheme = common_get_fromjson(ConstClass::SCHEMENAME_KEY, ConstClass::DEFSCHEMENAME_KEY)
    configuration = common_get_fromjson(ConstClass::CONFIGURATIONNAME_KEY, ConstClass::DEFCONFIGURATIONNAME_KEY)
    archive_path = common_get_fromjson(ConstClass::ARCHIVEPATH_KEY, ConstClass::DEFARCHIVEPATH_KEY)
    export_method = common_get_fromjson(ConstClass::EXPORTMETHOD_KEY, ConstClass::DEFEXPORTMETHOD_KEY)
    output_path = common_get_fromjson(ConstClass::OUTPUTPATH_KEY, ConstClass::DEFOUTPUTPATH_KEY)
    ipa_name = common_get_fromjson(ConstClass::APPNAME_KEY, ConstClass::DEFAPPNAME_KEY)
    user_key = common_get_fromjson(ConstClass::PGYERUSER_KEY, ConstClass::DEFPGYERUSER_KEY)
    api_key = common_get_fromjson(ConstClass::PGYERAIP_KEY, ConstClass::DEFPGYERAIP_KEY)
    ignoredesc = common_get_value(ConstClass::PGYERIGNOREDESC_KEY)

    puts "workspace_path: " + workspace_path
    puts "scheme: " + scheme
    puts "configuration: " + configuration
    puts "archive_path: " + archive_path
    puts "export_method: " + export_method
    puts "output_path: " + output_path
    puts "ipa_name: " + ipa_name
    puts "user_key: " + user_key
    puts "api_key: " + api_key

    script = "fastlane gym   --workspace #{workspace_path} --scheme #{scheme}  --configuration #{configuration} --archive_path #{archive_path} --export_method #{export_method} --output_directory #{output_path} --output_name #{ipa_name}"
    system script

    puts "================= 准备上传到蒲公英 ================="
    if user_key == nil  || api_key == nil
      puts "请配置蒲公英打包user_key和api_key"
      return
    end

    updatedesc = ""
    if !ignoredesc
      puts "请输入版本更新描述"
      updatedesc = STDIN.gets.chomp
    end
    ipa_path = output_path + ipa_name + ".ipa"
    pgyerscript = "curl -F 'file=@#{ipa_path}' -F 'uKey=#{user_key}' -F '_api_key=#{api_key}' -F 'buildInstallType=2' -F 'buildPassword=123456' -F 'buildUpdateDescription=#{updatedesc}'  https://www.pgyer.com/apiv2/app/upload"
    system pgyerscript

    puts ""
    puts "================= 上传到蒲公英 SUCCESS ================="
  end

  def init_def_config
    init_def_config_appname
    init_def_config_scheme
    init_def_config_configuration
    init_def_config_exportmethod
    init_def_config_output_path
    init_def_config_archive_path
    init_def_config_workspace_path
    init_def_config_pgyer
  end

  def init_def_config_appname
    defName = get_def_appname
    if defName.length > 0
      common_save(ConstClass::DEFAPPNAME_KEY, defName)
    end
  end

  def init_def_config_scheme
    defScheme = get_def_appname
    if defScheme.length > 0
      common_save(ConstClass::DEFSCHEMENAME_KEY, defScheme)
    end
  end

  def init_def_config_exportmethod
    common_save(ConstClass::DEFEXPORTMETHOD_KEY, "development")
  end

  def init_def_config_configuration
    common_save(ConstClass::DEFCONFIGURATIONNAME_KEY, "Debug")
  end

  def init_def_config_output_path
    appName = common_get_value(ConstClass::DEFAPPNAME_KEY)
    time = Time.new.strftime("%Y-%m-%d_%H-%M-%S").to_s
    path = ENV['HOME'] + '/Desktop/Ipa/' + appName + "/#{appName}_#{time}/"
    common_save(ConstClass::DEFOUTPUTPATH_KEY, path)
  end

  def init_def_config_archive_path
    outpath = common_get_value(ConstClass::DEFOUTPUTPATH_KEY)
    appName = common_get_value(ConstClass::DEFAPPNAME_KEY)
    path = outpath + appName + ".xcarchive"
    common_save(ConstClass::DEFARCHIVEPATH_KEY, path)
  end

  def init_def_config_workspace_path
    realPath = Dir.pwd
    scheme = common_get_value(ConstClass::DEFSCHEMENAME_KEY)
    extname = ".xcodeproj"
    arr = Dir.glob("*.xcworkspace")
    if arr.length > 0
      extname = ".xcworkspace"
    end
    path = "#{realPath}/#{scheme}#{extname}"
    common_save(ConstClass::DEFWORKSPACENAME_KEY, path)
  end

  def init_def_config_pgyer
    userkey = "99819322d3add2b6264a106367b50ede"
    apikey = "d14ed258b71d6be8cf2d6e03f8d5e7af"
    common_save(ConstClass::DEFPGYERUSER_KEY, userkey)
    common_save(ConstClass::DEFPGYERAIP_KEY, apikey)
  end

  def get_def_appname
    arr = Dir.glob("*.xcworkspace")
    if arr.length > 0
      arr << Dir.glob("*.xcodeproj")
    else
      arr = Dir.glob("*.xcodeproj")
    end
    if arr.length == 0
      puts "当前目录无工程文件"
      return nil
    end
    return arr[0].split('.')[0]
  end

  def common_get_fromjson(key, defkey)
    return BuildTool.cls_common_get_fromjson(key, defkey)
  end

  def self.cls_common_get_fromjson(key, defkey)
    value = ConfigTool.read_from_config_json(key)
    if value == nil
      value = ConfigTool.read_from_config_json(defkey)
    end
    return value
  end

  def common_get_value(key)
    return BuildTool.cls_common_get_value(key)
  end

  def self.cls_common_get_value(key)
    tool = ConfigTool.new(key)
    tool.create_file_not_exist
    obj = tool.read_from_config
    return obj
  end

  def common_save(key, value)
    tool = ConfigTool.new(key)
    tool.create_file_not_exist
    tool.save_content(value)
  end

end