# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "AuthorsController" do
  shared_context "parameters for new data" do
    parameter name: :name, in: :query, type: :string
  end

  shared_context "valid data" do
    let(:name) { "Susie" }
  end

  path "/api/authors" do
    get("list authors") do
      tags "Authors"
      produces "application/json"

      response(200, "successful") do
        before do
          create(:author)
          create(:author, name: "Ivy")
        end

        run_test! "correct response" do
          expect(json[:error]).to be_nil
          expect(json[:objects].size).to eq(2)
        end
      end
    end

    post("create author") do
      tags "Authors"
      produces "application/json"
      include_context "parameters for new data"

      response(200, "successful") do
        include_context "valid data"
        run_test!("correct response") { expect(json.dig(:object, :name)).to eq(name) }
      end
    end
  end

  path "/api/authors/{id}" do
    parameter name: "id", in: :path, type: :string

    let(:author) { create(:author) }
    let(:id) { author.id }

    get("show author") do
      tags "Authors"
      produces "application/json"

      response(200, "successful") do
        run_test!("correct response") { expect(json.dig(:object, :name)).to eq(author.name) }
      end
    end

    put("update author") do
      tags "Authors"
      produces "application/json"
      include_context "parameters for new data"

      response(200, "successful") do
        include_context "valid data"
        run_test!("correct response") { expect(json.dig(:object, :name)).to eq(name) }
      end
    end

    delete("delete author") do
      tags "Authors"
      produces "application/json"

      response(200, "successful") do
        run_test!("correct response") { expect(json.dig(:object, :name)).to eq(author.name) }
      end
    end
  end
end
