class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  has_many :comments, as: :commentable, dependent: :destroy

  # バリデーション
  validates :content,
            presence: true,
            length: { maximum: 1000 }

  def is_best_answer?(question)
    self == question.best_answer
  end
end
