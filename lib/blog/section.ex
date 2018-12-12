defmodule Blog.Section do
  use Blog.Schema

  schema "sections" do
    field :name, :string
  end
end
