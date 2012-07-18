class Expense < ActiveRecord::Base
  attr_accessible :description, :amount
  validates :description, :amount, presence: true

  belongs_to :user

  after_create :check_date

  def self.at_month(month = Date.today.month)
  	where('month(date) = ?', month)
  end

  def self.total_at_month(month = Date.today.month)
  	self.at_month(month).sum(:amount)
  end

  private

	def check_date
		self.update_attribute(:date, self.created_at) unless self.date.present?
	end
end
