# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    name { "Lasers" }
    author
    competences { [build(:competence), build(:competence, name: "Leadership")] }
  end
end
