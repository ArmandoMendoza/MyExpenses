class Transaction < ActiveRecord::Base
  attr_accessible :amount, :date, :description
  validates :description, presence: true
  validates :amount, numericality: true, presence: true

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