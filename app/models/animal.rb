class Animal < ApplicationRecord
    #belongs_to :user
    #belongs_to :category
    #add foreign key to table
    #animal foreign key belong to, category_id
    has_many :reasons
    has_many :users, through: :reasons
    #accepts_nested_attributes_for :reasons

    validates :name, presence: true
    validates :comment, presence: true

    scope :order_by_alphabetically, -> { order(name: :asc) }
    #to apply a scope method just put it as .chain at the end of a controller action

end
