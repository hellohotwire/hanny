class FeaturesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_feature, only: %i[ show edit update destroy ]

  def index
    @status_filter = params[:status_filter] || 'all'
    @search_query = params[:search]
    @pagy, @features = pagy(FeatureFilter.new(Feature.where(nil), @status_filter, @search_query).filtered_features)

    @feature = Feature.new

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def show
    @comment = Comment.new
    @comments = @feature.comments.where(parent_id: nil)
  end

  def new
    @feature = Feature.new
  end

  def edit
  end

  def create
    @feature = Feature.new(feature_params.merge(user: current_user))

    respond_to do |format|
      if @feature.save
        format.html { redirect_to features_path, notice: "Feature was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @feature.update(feature_params)
        format.html { redirect_to feature_url(@feature), notice: "Feature was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feature.destroy!

    respond_to do |format|
      format.html { redirect_to features_path, notice: "Feature was successfully destroyed." }
    end
  end

  private
    def set_feature
      @feature = Feature.find(params[:id])
    end

    def feature_params
      params.require(:feature).permit(:title, :description, :status)
    end
end
