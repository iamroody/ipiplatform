class Survey < ActiveRecord::Base
  has_many :questions
  attr_accessor :answers

  def score
    answer_ids = strip_ids(@answers)
    count_traits(answer_ids)
  end

  def strip_ids(answers)
    selected_trait_ids = []
    answers.each do |question_number, trait_id|
      selected_trait_ids << trait_id.to_i
    end
    selected_trait_ids
  end

  def count_traits (selected_trait_ids)
    trait_count = {}
    Trait.ids.each do |trait_id|
      selected_trait_count = selected_trait_ids.count(trait_id)
      trait_count[trait_id] = selected_trait_count
    end
    trait_count
  end

  def generate_questions
    trait_ids = Trait.ids
    spectrums = Spectrum.all
    spectrums.each do |spectrum|
      question_number = 0
      5.times do
        question = self.questions.build
        spectrum.traits.each do |trait|
          question.question_responses << trait.question_responses.fetch(question_number)
        end
        question_number += 1
      end
    end
  end
end
