module ApplicationHelper
	def title(page_title)
		content_for(:title) { page_title}
	end

	def title_capitalize title
		title.split(' ').map{|x| x.capitalize}.join(' ')		
	end

	def link_to_add_fields(name, f, association)
		new_object = f.object.send(association).build
		fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
			render(association.to_s.singularize + "_fields", :f => builder)			
		end
		link_to(name, "#", onclick: "add_fields(this, \"#{association}\",\"#{escape_javascript(fields)}\")", class: "btn btn-success")
	end

	def link_to_remove_fields(name, f)
		f.hidden_field(:_destroy) + link_to(name, '#', onclick: "remove_fields(this)", class: "btn btn-danger add-btn")
	end

	def cost price
  	number_to_currency(price, unit: "$.", format: "%u %n")
  end
end
