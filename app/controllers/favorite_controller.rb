class FavoriteController < ApplicationController
        
    def create
        favorite = current_user.favorites.create(post_id: params[:post_id])
        redirect_to post_path(params[:post_id]), notice: "#{favorite.post.user.name}, ce post a été ajouté a vos favoris"
    end
    
    def destroy
    favorite = current_user.favorites.find_by(post_id: params[:post_id]).destroy
    redirect_to post_path(params[:post_id]), notice: "post enlevé des favoris de M. #{favorite.post.user.name}"
    end
end
