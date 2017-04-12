class EntriesController < ApplicationController
  before_action :set_entry,    only: [:edit, :destroy, :show, :update ]
  before_action :logged_in?,   only: [:edit, :destroy, :create,       :index, :show]
  before_action :correct_user, only: [:edit, :destroy]

  # GET /entries
  def index
    @entries = Entry.all
  end

  # GET /entries/1
  def show
    @new_comment = Comment.build_from(@entry, current_user.id, "")
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Posted!"
      redirect_to entries_path
    else
      redirect_to user_path(current_user)
    end
  end

  # PATCH/PUT /entries/1
  def update
    if @entry.update_attributes(entry_params)
      flash[:success] = "Entry updated"
      redirect_to show_entry_path
    else
      flash[:error]
      render 'edit'
    end
  end

  # DELETE /entries/1
  def destroy
    @entry.destroy
    redirect_to user_path(current_user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    def entry_params
      params.require(:entry).permit(:caption, :location, :avatar, :user_id)
    end

    def correct_user
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end

end
