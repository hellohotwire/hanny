module FeaturesHelper
  def feature_status(feature)
    base_classes = "text-xs rounded-sm px-1 py-px"
    case feature.status
    when 'in_progress'
      content_tag :span, "In Progress", class: "bg-orange-300/40 text-orange-700 #{base_classes}"
    when 'open'
      content_tag :span, "Open", class: "bg-green-300/40 text-green-700 #{base_classes}"
    when 'done'
      content_tag :span, "Done", class: "bg-gray-300/40 text-gray-700 #{base_classes}"
    end
  end
end
