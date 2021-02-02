require 'json'

class ConfigTool
  @@jsonname = "ipa_config.json"
  def initialize(key)
    @jsonkey = key
  end

  def create_file_not_exist
    if !File.exists?(@@jsonname)
      File.new(@@jsonname, "w")
    end
  end

  def self.cls_create_file_not_exist
    if !File.exists?(@@jsonname)
      File.new(@@jsonname, "w")
    end
  end

  def save_content(cont)
    ConfigTool.cls_save_content(@jsonkey, cont)
  end

  def self.cls_save_content(key, cont)
    if cont.empty?
      puts "输入内容不能为空"
      return
    end
    json = File.read(@@jsonname)

    obj = Hash.new
    if json.length > 0
      obj = JSON.parse(json)
    end

    obj.store(key, cont)
    ConfigTool.cls_save_to_file(obj)
  end

  def save_to_file(obj)
    ConfigTool.cls_save_to_file(obj)
  end

  def self.cls_save_to_file(obj)
    json = JSON.generate(obj)
    aFile = File.new(@@jsonname, "r+")
    if aFile
      aFile.syswrite(json)
      #puts "保存成功: #{json}"
    else
      puts "保存失败"
    end
  end

  def read_from_config
    return ConfigTool.read_from_config_json(@jsonkey)
  end

  def self.read_from_config_json(key)
    if File.exists?(@@jsonname)
      json = File.read(@@jsonname)
      obj = nil
      if json.length > 0
        obj = JSON.parse(json)
      end
      return obj[key]
    end
    return nil
  end
end
