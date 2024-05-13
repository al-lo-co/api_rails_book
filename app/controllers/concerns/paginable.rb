module Paginable
  protected
  def current_page
    (params[:page] || 1).to_1
  end

  def per_page
    (params[:per_page] || 20).to_i
  end
end
