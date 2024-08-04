# frozen_string_literal: true

# Base class for database models.
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
