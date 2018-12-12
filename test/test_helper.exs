:ok = Ecto.Adapters.SQL.Sandbox.checkout(Blog.Repo)
Ecto.Adapters.SQL.Sandbox.mode(Blog.Repo, {:shared, self()})

ExUnit.start()
