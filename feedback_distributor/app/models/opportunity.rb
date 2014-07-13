class Opportunity < ActiveRecord::Base
  attr_accessible :description, :location, :status
end
