class BlogsController < ApplicationController

	before_action :auth_user, except: [:index, :show]

	def index
    	@blogs = Blog.page(params[:page] || 1).per_page(params[:per_page] || 10).
     	 order("id asc")
  	end

  	def new
  		@blog = Blog.new
  	end

	def show
  		@blog = Blog.find params[:id]
  	end

  	def create
    	@blog = Blog.new(params.require(:blog).permit(:title, :content))
    	@blog.user=current_user
    		if @blog.save
     		flash[:notice] = "create blog success"
      		redirect_to blogs_path
    		else
    		flash[:notice] = "create blog faild"
      		render action: :new
    		end
  	end

  	def signin_user user
      session[:user_id] = user.id
    end

    def logout_user
      session[:user_id] = nil
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      if logged_in?
        @current_user ||= User.find(session[:user_id])
      else
        nil    
      end
    end
 
  	def auth_user
  	  unless session[:user_id]
   	   flash[:notice] = "请登录"
   	   redirect_to new_session_path
   	  end
 	 end

end
