class ProcessFile < ActiveRecord::Base
  require 'fileutils'
  def self.save(script, problem_id, name)
    directory = File.join("public", "data", name, Problem.find_by_id(problem_id).title )#"public/data" 
    FileUtils::mkdir_p directory
    # create the file path
    path = File.join(directory, script.original_filename)
puts path
    # write the file
    File.open(path, "wb") { |f| f.write(script.read) }
  end
end
