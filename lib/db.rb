require 'pry-byebug'
require 'pg'

class DB

    def initialize
      @db = PG.connect(host: 'localhost', dbname: 'task-manager')
      build_tables
    end

   def build_tables
     @db.exec(%q[
       CREATE TABLE IF NOT EXISTS projects(
         id serial NOT NULL PRIMARY KEY,
         name varchar(30)
       )])

     @db.exec(%q[
       CREATE TABLE IF NOT EXISTS tasks(
         id serial NOT NULL PRIMARY KEY,
         project_id integer REFERENCES projects(id),
         priority integer,
         description text,
         status varchar(10),
         created_at timestamp NOT NULL DEFAULT current_timestamp
       )])
    end

     @db.exec(%Q[
        CREATE TABLE IF NOT EXISTS employees(
          id serial NOT NULL PRIMARY KEY,
          task_id integer REFERENCES tasks(id),
          name varchar(20),
          task
          )])

       # @db.exec(%Q[
       #  CREATE TABLE IF NOT EXISTS
       #  ])



    def create_project(name)
      name = data["name"]
      id = @db.exec_params(%Q[
        INSERT INTO projects (name) VALUES ($1)
        RETURNING id;
      ], [name])
      data["data"] = id
      TM::Project.new(data)
    end

    def update_project(data)
      id = data["id"]
      name = data["name"]
      response = @db.exec_params(%Q[
        UPDATE projects
        SET (name) = ($1)
        WHERE id = $2;
      ], [name, id])
      TM::Project.new(response)
    end

    def destroy_project(id)
      @db.exec(%Q[
        DELETE projects WHERE id = #{id};
      ])
    end

    def get_project_by_id(id)
      project = @db.exec_params(%Q[
        SELECT * FROM projects WHERE id = $1;
      ], [id])
      data = project.first
      TM::Project.new(data)
    end

    def create_task(priority, pid, description)
      id = @db.exec_params(%Q[
        INSERT INTO tasks (priority, project_id, description) VALUES ($1, $2, $3)
        RETURNING id;
      ], [priority, pid, description])
      TM::Task.new(data)
    end

    def get_task(pid)
      task = @db.exec_params(%Q[
        SELECT * FROM tasks WHERE pid = $1;
        ], [pid])
      data = task.first
      TM::Task.new(data)
    end

    def update_task(id, data)
      id = data["id"]
      complete = data["complete"]
      response = @db.exec_params(%Q[
        UPDATE tasks
        SET (complete) = ($1)
        WHERE id = $2;
      ], [complete, id])

    end
  end
