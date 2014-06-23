
class TM::Task
  attr_reader :priority, :tid, :description, :pid, :time
  attr_accessor :status

  def initialize priority, pid, description
    @priority = data[:priority]
    @pid = data[:pid]
    @description = data[:description]
    @status = data [:incomplete]
    @time = Time.now
  end

  def complete
    @status = :complete
  end

  def self.mark_complete tid
   task = @@tasks.find{|t| t.tid == tid}
   task.complete
  end

  def self.get_tasks
    @@tasks
  end

end
