class Analytics < ActiveRecord::Base
  scope :hits_by_ip, ->(ip,col="*") { select("#{Analytics.joiny_join(col)}").where(:ip_address => ip).order("id DESC")}

  def self.count_by_col(col)
    calculate(:count, col)
  end

  def self.parse_field(field)
    valid_fields = ["ip_address", "referrer", "user_agent"]

    if valid_fields.include?(field)
      field
    else
      "1"
    end
  end

  def self.joiny_join(fields)
    if fields = "*"
      "*"
    else
      fields.map {|k,v| Analytics.parse_field(k) }.join(",")
    end
  end
end
