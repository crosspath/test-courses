require "swagger_helper"

RSpec.describe "AuthorsController", type: :request do
  path "/api/authors" do
    get("list authors") do
      produces "application/json"

      response(200, "successful") do
        before do
          create(:author)
          create(:author, name: "Ivy")
        end

        run_test! do
          expect(json[:error]).to be_nil
          expect(json[:objects].size).to eq(2)
        end
      end
    end

    post("create author") do
      produces "application/json"

      parameter name: :name, in: :query, type: :string

      response(200, "successful") do
        let(:name) { "Susie" }

        run_test! { expect(json.dig(:object, :name)).to eq(name) }
      end
    end
  end

  path "/api/authors/{id}" do
    parameter name: "id", in: :path, type: :string

    let(:author) { create(:author) }
    let(:id) { author.id }

    get("show author") do
      produces "application/json"

      response(200, "successful") do
        run_test! { expect(json.dig(:object, :name)).to eq(author.name) }
      end
    end

    put("update author") do
      produces "application/json"

      parameter name: :name, in: :query, type: :string

      response(200, "successful") do
        let(:name) { "Susie" }

        run_test! { expect(json.dig(:object, :name)).to eq(name) }
      end
    end

    delete("delete author") do
      produces "application/json"

      response(200, "successful") do
        run_test! { expect(json.dig(:object, :name)).to eq(author.name) }
      end
    end
  end
end
