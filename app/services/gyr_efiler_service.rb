class GyrEfilerService
  CURRENT_VERSION = '1105349922f7be08cb3a2d8f1d1438eb72b9f5d2'

  def self.run_efiler_command(*args)
    raise StandardError.new("Cannot be used from the test environment") if Rails.env.test?

    Dir.mktmpdir do |working_directory|
      FileUtils.mkdir_p(File.join(working_directory, "output", "log"))
      ensure_config_dir_prepared

      # TODO: If the process blocks for >10 min, terminate it.
      # TODO: Send process stdout to logs.
      # TODO: Send output/logs/ to logs after process terminates.
      classes_zip_path = Dir.glob(Rails.root.join("vendor", "gyr_efiler", "gyr-efiler-classes-#{CURRENT_VERSION}.zip"))[0]

      config_dir = Rails.root.join("tmp", "gyr_efiler", "gyr_efiler_config").to_s

      pid = Process.spawn(
        "java", "-cp", classes_zip_path, "org.codeforamerica.gyr.efiler.App", config_dir, *args,
        unsetenv_others: true,
        chdir: working_directory,
        in: "/dev/null"
      )
      Process.wait(pid)
      raise StandardError.new("Process failed to exit?") unless $?.exited?

      exit_code = $?.exitstatus
      raise StandardError.new("gyr-efiler failed; exited with #{exit_code}") if exit_code != 0

      get_single_file_from_zip(Dir.glob(File.join(working_directory, "output", "*.zip"))[0])
    end
  end

  def self.get_single_file_from_zip(zipfile_path)
    Zip::File.open(zipfile_path) do |zipfile|
      entries = zipfile.entries
      raise StandardError.new("Zip file contains more than 1 file") if entries.size != 1
      # In that case, might be good to archive the ZIP file before the working directory gets deleted

      return zipfile.read(entries.first.name)
    end
  end

  private

  def self.ensure_config_dir_prepared
    config_dir = Rails.root.join("tmp", "gyr_efiler", "gyr_efiler_config")
    FileUtils.mkdir_p(config_dir)
    return if File.exists?(File.join(config_dir, '.ready'))

    config_zip_path = Dir.glob(Rails.root.join("vendor", "gyr_efiler", "gyr-efiler-config-#{CURRENT_VERSION}.zip"))[0]
    system("unzip -o #{config_zip_path} -d #{Rails.root.join("tmp", "gyr_efiler")}")

    local_efiler_repo_config_path = File.expand_path('../gyr-efiler/gyr_efiler_config', Rails.root)
    if Rails.env.development?
      begin
        FileUtils.cp(File.join(local_efiler_repo_config_path, 'gyr_secrets.properties'), config_dir)
        FileUtils.cp(File.join(local_efiler_repo_config_path, 'secret_key_and_cert.p12.key'), config_dir)
      rescue
        raise StandardError.new("Please clone the gyr-efiler repo to ../gyr-efiler and follow its README")
      end
    else
      required_env_keys = %w[GYR_EFILER_ETIN GYR_EFILER_APP_SYS_ID GYR_EFILER_CERT]
      missing_keys = required_env_keys.reject { |key| ENV.has_key?(key) }
      if missing_keys.length > 0
        raise StandardError.new("Missing required env keys: #{missing_keys.join(', ')}")
      end

      properties_content = <<~PROPERTIES
        etin=#{ENV['GYR_EFILER_ETIN']}
        app_sys_id=#{ENV['GYR_EFILER_APP_SYS_ID']}
      PROPERTIES
      File.write(File.join(config_dir, 'gyr_secrets.properties'), properties_content)
      File.write(File.join(config_dir, 'secret_key_and_cert.p12.key'), Base64.decode64(ENV['GYR_EFILER_CERT']))
    end

    FileUtils.touch(File.join(config_dir, '.ready'))
  end
end
