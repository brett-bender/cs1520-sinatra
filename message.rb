class Message < ActiveRecord::Base
  validates_presence_of :email
  validates_presence_of :message
end
