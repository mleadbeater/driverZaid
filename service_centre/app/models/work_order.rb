class WorkOrder < ActiveRecord::Base
  attr_accessible :category, :description, :due, :status
end
