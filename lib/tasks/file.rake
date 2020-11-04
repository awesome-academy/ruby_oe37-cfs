namespace :file do
  desc "Create example file"
  task :create_example do
    gitignore = File.open Rails.root.join(".gitignore"), "a"

    file_names = ["config/database.yml",
      "config/credentials.yml.enc",
      "config/storage.yml"]

    file_names.each do |file|
      FileUtils.cp file, file + ".example"
      gitignore << file + "\n"
    end
    gitignore.close
  end

  desc "Remove default comments"
  task :gemfile_format do
    file_names = ["Gemfile", "config/application.rb"]

    file_names.each do |file_name|
      text = File.read file_name

      # Remove comments
      new_contents = text.gsub(/^\s*#.*/, "")
      # Single quotes => Double quotes
      new_contents.gsub!(/'/, '"')
      # Remove excess lines
      new_contents.gsub!(/^$\n/, "")

      puts new_contents
      File.open(file_name, "w"){|file| file.puts new_contents}
    end
  end
end
