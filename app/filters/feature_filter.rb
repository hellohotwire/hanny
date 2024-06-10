class FeatureFilter
  def initialize(features, filter, search_query)
    @features = features
    @filter = filter
    @search_query = search_query
  end

  def filtered_features
    features = apply_filter
    features = apply_search(features)
    features
  end

  private

  def apply_filter
    case @filter
    when 'new'
      @features.order(created_at: :desc)
    when 'old'
      @features.order(created_at: :asc)
    when 'open'
      @features.open
    when 'in_progress'
      @features.in_progress
    when 'done'
      @features.done
    else
      @features
    end
  end

  def apply_search(features)
    if @search_query.present?
      features.where("title LIKE :query OR description LIKE :query", query: "%#{@search_query}%")
    else
      features
    end
  end
end
