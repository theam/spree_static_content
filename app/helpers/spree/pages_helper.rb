module Spree
  module PagesHelper
    def render_snippet(slug)
      page = Spree::Page.find_by_slug(slug)
      raw page.body if page
    end

    def static_page_slug_with_current_language(page_slug)
      "/#{current_language_from_locale}#{page_slug}"
    end

    def current_language_from_locale
      I18n.locale&.to_s&.split("-")&.first || I18n.locale
    end
  end
end
