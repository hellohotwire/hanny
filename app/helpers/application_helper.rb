module ApplicationHelper
  include Pagy::Frontend

  def user_avatar_with_name(user)
    content_tag :div, class: "flex items-center gap-3" do
      avatar = content_tag(:div, class: "rounded-full size-6 text-xs flex items-center justify-center font-semibold #{['bg-red-100', 'bg-blue-100', 'bg-green-100', 'bg-pink-100', 'bg-purple-100'].sample}") do
        user.first_name.first.upcase
      end

      name = content_tag(:p, user.name, class: "font-medium text-sm")

      avatar + name
    end
  end
end
