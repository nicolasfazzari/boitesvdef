class Boite < ActiveRecord::Base

	geocoded_by :commune
	geocoded_by :full_address
	after_validation :geocode, if: ->(obj){ !obj.latitude.present? }

	def full_address
		"#{departement},#{zip},#{commune}"
	end

	

	def self.to_csv(options = {})
	  CSV.generate(options) do |csv|
	    csv << column_names
	    all.each do |product|
	      csv << product.attributes.values_at(*column_names)
	    end
	  end
	end

end
