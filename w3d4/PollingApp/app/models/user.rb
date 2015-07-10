class User < ActiveRecord::Base
  has_many(
    :authored_polls,
    class_name: :Poll,
    primary_key: :id,
    foreign_key: :author
  )

  has_many(
    :responses,
    class_name: :Response,
    primary_key: :id,
    foreign_key: :user_id
  )
end
