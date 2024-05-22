class ViewingPartiesController < ApplicationController
  def new
    if current_user
      @facade = MovieFacade.new(id: params[:movie_id])
    else
      flash[:error] = 'You must be logged in or registered to create a Viewing Party.'
      redirect_to root_path
    end
  end

  def create
    party = ViewingParty.new(party_params)
    guests = [params[:guest_1], params[:guest_2], params[:guest_3]].map { |guest| User.find_by(email: guest) }.compact

    if party.save
      party.user_parties.create(user_id: current_user.id, host: true)
      guests.each { |guest| party.user_parties.create(user_id: guest.id, host: false) }

      flash[:success] = 'Successfully Created New Viewing Party'
      redirect_to user_path(current_user)
    else
      flash[:error] = "#{error_message(party.errors)}" # rubocop:disable Style/RedundantInterpolation
      redirect_to new_movie_viewing_party_path(params[:movie_id])
    end
  end

  def show
    @facade = MovieFacade.new(id: params[:movie_id])
  end

  private

  def party_params
    params.permit(:duration, :date, :start_time, :movie_id)
  end
end
