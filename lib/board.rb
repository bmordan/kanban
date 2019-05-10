class Board < ActiveRecord::Base
  has_many :tasks

  def as_cols
    cols = Hash.new([])
    cols[:todo] = self.tasks.filter { |t| t.colname == "todo" }
    cols[:doing] = self.tasks.filter { |t| t.colname == "doing" }
    cols[:done] = self.tasks.filter { |t| t.colname == "done" }
    return cols
  end
end
