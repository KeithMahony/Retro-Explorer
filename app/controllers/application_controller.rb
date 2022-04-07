class ApplicationController < ActionController::Base
  before_action :set_breadcrumbs

    # Keep track of user movement through application
    private
    def set_breadcrumbs
      if session[:breadcrumbs]
        @breadcrumbs = session[:breadcrumbs]
      else
      @breadcrumbs = Array.new
      end

      @breadcrumbs.push(request.url)

      if @breadcrumbs.count > 4
        @breadcrumbs.shift
      end

      session[:breadcrumbs] = @set_breadcrumbs

    end

end
