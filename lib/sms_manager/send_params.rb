require "active_model"

class SendParams
  include ActiveModel::Validations

  attr_accessor :number, :message, :username, :password

  validates_presence_of :number, :username, :password

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
end