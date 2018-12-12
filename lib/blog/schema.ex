defmodule Blog.Schema do
  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Ecto.Query, warn: false
      import Blog.Schema

      alias Blog.Country
      alias Blog.Language
      alias Blog.Post
      alias Blog.Repo
      alias Blog.Section
      alias Blog.User
      alias Ecto.Changeset

    end
  end
end
