class User < ActiveRecord::Base
  has_many :characters
  has_secure_password

  def self.delete_all
    self.all.each do |x|
      x.delete
    end
  end
  
end
