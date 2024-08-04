# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "CompetencesController" do
  shared_context "parameters for new data" do
    parameter name: :name, in: :query, type: :string
  end

  shared_context "valid data" do
    let(:name) { "Mentoring" }
  end

  path "/api/competences" do
    get("list competences") do
      tags "Competences"
      produces "application/json"

      response(200, "successful") do
        before do
          create(:competence)
          create(:competence, name: "Screwing")
        end

        run_test! "correct response" do
          expect(json[:error]).to be_nil
          expect(json[:objects].size).to eq(2)
        end
      end
    end

    post("create competence") do
      tags "Competences"
      produces "application/json"
      include_context "parameters for new data"

      response(200, "successful") do
        include_context "valid data"
        run_test!("correct response") { expect(json.dig(:object, :name)).to eq(name) }
      end
    end
  end

  path "/api/competences/{id}" do
    parameter name: "id", in: :path, type: :string

    let(:competence) { create(:competence) }
    let(:id) { competence.id }

    get("show competence") do
      tags "Competences"
      produces "application/json"

      response(200, "successful") do
        run_test!("correct response") { expect(json.dig(:object, :name)).to eq(competence.name) }
      end
    end

    put("update competence") do
      tags "Competences"
      produces "application/json"
      include_context "parameters for new data"

      response(200, "successful") do
        include_context "valid data"
        run_test!("correct response") { expect(json.dig(:object, :name)).to eq(name) }
      end
    end

    delete("delete competence") do
      tags "Competences"
      produces "application/json"

      response(200, "successful") do
        run_test!("correct response") { expect(json.dig(:object, :name)).to eq(competence.name) }
      end
    end
  end
end
