defmodule Blog.User do
  use Blog.Schema

  schema "users" do
    field :name, :string
    belongs_to :country, Country
    belongs_to :language, Language
  end
end
