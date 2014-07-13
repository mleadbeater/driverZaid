class WelcomeController < ApplicationController
  def index
	@work_orders = WorkOrder.all
	@opportunities = Opportunity.all
  end
end
