defmodule Blog.Post do
  use Blog.Schema

  schema "posts" do
    field :name, :string
    belongs_to :user, User
    belongs_to :section, Section
  end
end
