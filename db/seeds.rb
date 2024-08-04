author_names = %w[
  Johann
  Gregory
  Ivan
]

# Author#name => {Course#name => [Competence#name, ...], ...}
courses = {
  "Johann" => {
    "Statistics" => ["Maths"]
  },
  "Gregory" => {
    "3D Modelling" => ["Maths", "Analysis"],
    "AI" => ["Maths"]
  },
  "Ivan" => {
    "Geospatial Data Processing" => ["Maths", "Fuzzy Search"]
  }
}

# @param author_names [Array<String>]
# @return [Hash<String, Author>]
def create_authors(author_names)
  author_names.index_with { |it| Author.find_or_create_by!(name: it) }
end

# @param courses [Hash<String, Hash<String, Array<String>>>]
# @return [Hash<String, Competence>]
def create_competences(courses)
  competence_names =
    courses.reduce(Set.new) do |acc, (_author_name, courses_hash)|
      acc + courses_hash.values.flatten
    end

  competence_names.index_with { |it| Competence.find_or_create_by!(name: it) }
end

# @param courses [Hash<String, Hash<String, Array<String>>>]
# @param authors [Hash<String, Author>]
# @param competences [Hash<String, Competence>]
# @return [Hash<String, Course>]
def create_courses(courses, authors, competences)
  courses.each_with_object([]) do |(author_name, courses_hash), acc|
    author = authors[author_name]
    courses_hash.each do |course_name, competences_list|
      course = Course.find_or_create_by!(name: course_name, author: authors[author_name])
      course.competences = competences.slice(*competences_list).values
      acc << course
    end
  end
end

# @param count [Integer]
# @param singular_form [String]
# @param plural_form [String]
# @return [String]
def pluralize(count, singular_form, plural_form)
  count == 1 ? singular_form : plural_form
end

authors = create_authors(author_names)
competences = create_competences(courses)
courses = create_courses(courses, authors, competences)

results = [
  {count: authors.size, s: "author", p: "authors"},
  {count: competences.size, s: "competence", p: "competences"},
  {count: courses.size, s: "course", p: "courses"}
]

puts "Created:"
results.each { |it| puts "#{it[:count]} #{pluralize(it[:count], it[:s], it[:p])}" }
