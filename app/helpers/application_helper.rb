module ApplicationHelper

	def alert_type(name, msg)
		type = name == :notice ? "success" : "error"
		class_name = "alert alert-#{type}"
		content_tag(:div, class: class_name) do
			link_to("x", "#", class: "close", data: { dismiss: "alert" }) +
			content_tag(:b, msg)
		end
	end

	def navbar(title)
		content_tag(:div, class: "navbar") do
			content_tag(:div, class: "navbar-inner") do
				content_tag(:div, class: "container") do
					link_to(title,"#", class: "brand") +
					content_tag(:ul, class: "nav") do
						yield
					end
				end
			end
		end
	end
end
