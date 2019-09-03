require "sinatra"
require "sinatra/activerecord"
require "sinatra-websocket"
require "./lib/user"
require "./lib/board"
require "./lib/task"
require "pry"

class Server < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions
  set :sockets, Hash.new

  get "/users" do
    erb :users, :locals => { users: User.all }, :layout => :layout
  end

  get "/user/:id" do |id|
    erb :user, locals: { user: User.find(id) }, :layout => :layout
  end

  get /\/|\/boards/ do
    erb :boards, :locals => { boards: Board.all }, :layout => :layout
  end

  post "/board" do
    Board.create(title: params["title"])
    erb :boards, :locals => { boards: Board.all }, :layout => :layout
  end

  get "/board/:id/socket" do |board_id|
    request.websocket do |ws|
      ws.onopen do
        if settings.sockets.key?(board_id)
          settings.sockets[board_id] << ws
        else
          settings.sockets[board_id] = [ws]
        end
      end

      ws.onmessage do |msg|
        board_id, task_id, colname = msg.split("|")
        board = Board.find(board_id)
        task = Task.find(task_id)
        previous_colname = task.colname
        task.colname = colname
        task.status = colname == "done" ? "done" : "pending"
        task.save
        settings.sockets[board_id].each { |ws| ws.send([task_id, previous_colname, colname].join("|")) }
      end

      ws.onclose do
        settings.sockets[board_id].delete(ws)
      end
    end
  end

  get "/board/:id" do |id|
    board = Board.find(id)
    erb :board, :locals => { board: board, cols: board.as_cols, users: User.all }, :layout => :layout_board
  end

  post "/board/:id/task" do |id|
    task = params.reject { |key, val| key == "id" }
    Task.create(task)
    board = Board.find(id)
    erb :board, :locals => { board: board, cols: board.as_cols, users: User.all }, :layout => :layout_board
  end

  get "/board/:id/delete" do |id|
    Board.delete(id)
    erb :boards, :locals => { boards: Board.all }, :layout => :layout
  end
end
