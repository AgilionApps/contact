require 'mongoid'

Mongoid.database = Mongo::Connection.new(settings.storage['host'], settings.storage['port']).db(settings.storage['database'])
Mongoid.database.authenticate(settings.storage['username'], settings.storage['password'])

class Contact
  include Mongoid::Document

  field :first_name,    type: String
  field :last_name,     type: String
  field :email_address, type: String
  field :message,       type: String

  def full_name
    "#{first_name} #{last_name} "
  end
end
