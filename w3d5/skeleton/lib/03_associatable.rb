require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.to_s.constantize
  end

  def table_name
    class_name.to_s.downcase + "s"
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @primary_key = :id
    @foreign_key = "#{name}_id".to_sym
    @class_name = name.capitalize

    options.each do |key, value|
      if key == :class_name
        @class_name = value
      elsif key == :foreign_key
        @foreign_key = value
      elsif key == :primary_key
        @primary_key = value
      end
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @primary_key = :id
    @foreign_key = "#{self_class_name}_id".downcase.to_sym
    @class_name = name.to_s.capitalize.singularize

    options.each do |key, value|
      if key == :class_name
        @class_name = value
      elsif key == :foreign_key
        @foreign_key = value
      elsif key == :primary_key
        @primary_key = value
      end
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    define_method(name) do
      fk = self.send(options.foreign_key)
      target_model = options.model_class
      target_model.where(options.primary_key => fk).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.name, options)
    define_method(name) do
      fk = self.send(options.primary_key)
      target_model = options.model_class
      target_model.where(options.foreign_key => fk)
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  extend Associatable
end
