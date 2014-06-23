require 'pry-byebug'
require 'pg'
# Create our module. This is so other files can start using it immediately
module TM
  def self.db
    @__db_instance ||= DB.new
  end
end

# Require all of our project files
require_relative 'db.rb'
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/terminal.rb'


terminal = TM::Terminal.new
terminal.print_menu
