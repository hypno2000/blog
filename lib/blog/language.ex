defmodule Blog.Language do
  use Blog.Schema

  schema "languages" do
    field :name, :string
  end
end
