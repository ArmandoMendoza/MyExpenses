module DashboardHelper

	def label_for_balance(amount)
		class_name = amount < 0 ? "label label-important" : "label label-success"

		content_tag(:span, number_to_currency(amount), class: class_name)
	end

	def label_for_amount(amount, class_name = "")
		content_tag(:span, number_to_currency(amount), class: "label #{class_name}")
	end
end
