require "swagger_helper"

RSpec.describe "CoursesController", type: :request do
  shared_context "parameters for new data" do
    parameter name: :name, in: :query, type: :string
    parameter name: :author_id, in: :query, type: :string
    parameter name: :competence_ids, in: :query, type: :string
  end

  shared_context "valid data" do
    let(:name) { "Batch Processing" }
    let(:author_id) { create(:author).id }
    let(:competence_ids) do
      [create(:competence).id, create(:competence, name: "Mentoring").id].join(",")
    end
  end

  path "/api/courses" do
    get("list courses") do
      tags "Courses"
      produces "application/json"

      response(200, "successful") do
        before do
          create(:course)
          create(:course, name: "Highly Excessive Metals")
        end

        run_test! do
          expect(json[:error]).to be_nil
          expect(json[:objects].size).to eq(2)
        end
      end
    end

    post("create course") do
      tags "Courses"
      produces "application/json"
      include_context "parameters for new data"

      response(200, "successful") do
        include_context "valid data"
        run_test! { expect(json.dig(:object, :name)).to eq(name) }
      end
    end
  end

  path "/api/courses/{id}" do
    parameter name: "id", in: :path, type: :string

    let(:course) { create(:course) }
    let(:id) { course.id }

    get("show course") do
      tags "Courses"
      produces "application/json"

      response(200, "successful") do
        run_test! { expect(json.dig(:object, :name)).to eq(course.name) }
      end
    end

    put("update course") do
      tags "Courses"
      produces "application/json"
      include_context "parameters for new data"

      response(200, "successful") do
        include_context "valid data"
        run_test! { expect(json.dig(:object, :name)).to eq(name) }
      end
    end

    delete("delete course") do
      tags "Courses"
      produces "application/json"

      response(200, "successful") do
        run_test! { expect(json.dig(:object, :name)).to eq(course.name) }
      end
    end
  end
end
