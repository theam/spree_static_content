module Spree
  class StaticContentController < StoreController
    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    helper 'spree/products'
    layout :determine_layout

    def show
      I18n.with_locale(language_from_locale) do
        @page = Spree::Page.joins(:translations).by_store(current_store)
                    .visible
                    .find_by!(slug: ("/#{params[:path]}"))
      end
    end

    private

    def language_from_locale
      params[:locale].split("-")&.first || params[:locale]
    end

    def determine_layout
      return @page.layout if @page && @page.layout.present? && !@page.render_layout_as_partial?
      Spree::Config.layout
    end

    def accurate_title
      @page ? (@page.meta_title.present? ? @page.meta_title : @page.title) : nil
    end
  end
end
