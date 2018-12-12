defmodule Blog.Country do
  use Blog.Schema

  schema "countries" do
    field :name, :string
  end
end
