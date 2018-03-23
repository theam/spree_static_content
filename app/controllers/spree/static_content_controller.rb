module Spree
  class StaticContentController < StoreController
    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    helper 'spree/products'
    layout :determine_layout

    def show
      path = request.path.dup
      request_path_split = request.path.split('/')
      locale = request_path_split[1] if request_path_split.size > 1
      path.remove!("/#{locale}") if !locale.blank? && (%w(es fr en).include?(locale))
      @page = Spree::Page.joins(:translations).by_store(current_store).visible.find_by!(slug: path)
    end

    private

    def determine_layout
      return @page.layout if @page && @page.layout.present? && !@page.render_layout_as_partial?
      Spree::Config.layout
    end

    def accurate_title
      @page ? (@page.meta_title.present? ? @page.meta_title : @page.title) : nil
    end
  end
end
