# frozen_string_literal: true

# Disallow storing courses without authors.
module Authors::Delete
  extend self

  # At least one author should exist if courses exist.
  class LastAuthorError < RuntimeError
    def initialize(_ = nil)
      super("Cannot remove this author because no other authors known in database")
    end
  end

  # @param author [Author]
  # @raise LastAuthorError
  # @return [Author] Another author set to courses
  def call(author)
    author.transaction do
      if author.courses.any?
        another_author = Author.excluding(author).sample
        raise LastAuthorError unless another_author

        author.courses.update_all(author: another_author)
      end

      author.delete
    end
  end
end
