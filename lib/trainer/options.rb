module Trainer
  class Options
    def self.available_options
      @options ||= [
        FastlaneCore::ConfigItem.new(key: :path,
                                     short_option: "-p",
                                     env_name: "TRAINER_PATH",
                                     optional: true,
                                     description: "Path to the directory that should be converted",
                                     verify_block: proc do |value|
                                       v = File.expand_path(value.to_s)
                                       if v.end_with?(".plist")
                                         UI.user_error!("Can't find file at path #{v}") unless File.exist?(v)
                                       else
                                         UI.user_error!("Path '#{v}' is not a directory or can't be found") unless File.directory?(v)
                                       end
                                     end),
        FastlaneCore::ConfigItem.new(key: :extension,
                                     short_option: "-e",
                                     env_name: "TRAINER_EXTENSION",
                                     default_value: ".xml",
                                     description: "The extension for the newly created file. Usually .xml or .junit",
                                     verify_block: proc do |value|
                                       UI.user_error!("extension must contain a `.`") unless value.include?(".")
                                     end),
        FastlaneCore::ConfigItem.new(key: :output_directory,
                                     short_option: "-o",
                                     env_name: "TRAINER_OUTPUT_DIRECTORY",
                                     default_value: nil,
                                     optional: true,
                                     description: "Directoy in which the xml files should be written to. Same directory as source by default"),
        FastlaneCore::ConfigItem.new(key: :fail_build,
                                     env_name: "TRAINER_FAIL_BUILD",
                                     description: "Should this step stop the build if the tests fail? Set this to false if you're handling this with a test reporter",
                                     is_string: false,
                                     default_value: true),
        FastlaneCore::ConfigItem.new(key: :xcpretty_naming,
                                     short_option: "-x",
                                     env_name: "TRAINER_XCPRETTY_NAMING",
                                     description: "Produces class name and test name identical to xcpretty naming in junit file",
                                     is_string: false,
                                     default_value: false)
      ]
    end
  end
end
