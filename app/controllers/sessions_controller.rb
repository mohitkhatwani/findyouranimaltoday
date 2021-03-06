class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        user = User.find_by(name: params[:name])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            @user = user
            redirect_to user_path(@user)
        else
            render 'sessions/wrong_password'
        end   
     end

    def destroy
        session.delete("user_id")
        redirect_to new_session_path
    end

    def omniauth #logs users in with omniauth
        user = User.create_from_omniauth(auth)
        if user.valid?
            session[:user_id] = user.id
            redirect_to new_category_path
        else
            flash[:message] = user.errors.full_messages.join(", ")
            redirect_to '/'
        end
    end

    private
    def auth
        request.env['omniauth.auth']
    end
    
end