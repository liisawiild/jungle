module Admin::SalesHelper
  def active_sale?
    #calling an instance/class method
    Sale.active.any?
  end

 end
