require "sinatra"
require "sinatra/activerecord"
require "./lib/user"
require "./lib/board"
require "./lib/task"

class Server < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions

  get "/" do
    erb :users, :locals => { users: User.all }, :layout => :layout
  end

  get "/boards" do
    erb :boards, :locals => { boards: Board.all }, :layout => :layout
  end

  post "/board" do
    Board.create(title: params["title"])
    erb :boards, :locals => { boards: Board.all }, :layout => :layout
  end

  get "/board/:id" do |id|
    board = Board.find(id)
    puts board.as_cols
    erb :board, :locals => { board: board, cols: board.as_cols }, :layout => :layout_board
  end

  post "/board/:id/task" do |id|
    task = params.reject { |key, val| key == "id" }
    Task.create(task)
    board = Board.find(id)
    erb :board, :locals => { board: board, cols: board.as_cols }, :layout => :layout_board
  end

  get "/board/:board_id/task/:task_id/colname/:colname" do |board_id, task_id, colname|
    board = Board.find(board_id)
    task = Task.find(task_id)
    task.colname = colname
    task.status = colname == "done" ? "done" : "pending"
    task.save
    erb :board, :locals => { board: board, cols: board.as_cols }, :layout => :layout_board
  end
end
