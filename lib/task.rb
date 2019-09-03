class Task < ActiveRecord::Base
  belongs_to :boards
  belongs_to :user
end
