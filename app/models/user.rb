class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable, recoverable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable


  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  validates :name, :email, :password, presence: true

  has_many :expenses
  has_many :incomes

  def expenses_at_month(month = Date.today.month)
    expenses.at_month(month)
  end

  def total_expenses_at_month(month = Date.today.month)
    expenses.total_at_month(month)
  end

  def incomes_at_month(month = Date.today.month)
    incomes.at_month(month)
  end

  def total_incomes_at_month(month = Date.today.month)
    incomes.total_at_month(month)
  end

  def balance(month = Date.today.month)
    total_incomes_at_month(month) - total_expenses_at_month(month)
  end
end