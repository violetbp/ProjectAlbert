class ProcessFile < ActiveRecord::Base
  require 'fileutils'
  def self.save(script, problem_id, name)
    directory = File.join("public", "data", current_user.username.tr(" ", "_"), problem_id) 
    FileUtils::mkdir_p directory
    # create the file path
    path = File.join(directory, script.original_filename)
    # write the file
    File.open(path, "wb") { |f| f.write(script.read) }
  end

end
