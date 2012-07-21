class Transaction < ActiveRecord::Base
  attr_accessible :amount, :date, :description
  validates :description, presence: true
  validates :amount, numericality: true, presence: true

  belongs_to :user

  before_create :check_date
  before_save :capitalize_description

  def self.at_month(month = Date.today.month)
  	where('month(date) = ?', month)
  end

  def self.total_at_month(month = Date.today.month)
  	self.at_month(month).sum(:amount)
  end

  private

	def check_date
		self.date = Date.today unless self.date.present?
	end

  def capitalize_description
    self.description = self.description.capitalize
  end
end