defmodule BlogTest do
  use ExUnit.Case

  alias Blog.{Repo, User, Post, Country, Language, Section}

  import Ecto.Query

  setup do
    language = %Language{name: "language1"} |> Repo.insert!()
    country = %Country{name: "country1"} |> Repo.insert!()

    user =
      %User{name: "user1", language_id: language.id, country_id: country.id} |> Repo.insert!()

    section = %Section{name: "section1"} |> Repo.insert!()
    post = %Post{name: "post1", user_id: user.id, section_id: section.id} |> Repo.insert!()

    {:ok, post_id: post.id}
  end

  test "chaining preload assocs", %{post_id: post_id} do
    post =
      from(p in Post, as: :post, where: p.id == ^post_id)
      |> preload(:section)
      |> preload(:user)
      |> Repo.one!()

    assert %Section{} = post.section
    assert %User{} = post.user
  end

  test "preloading nested assocs", %{post_id: post_id} do
    post =
      from(p in Post, as: :post, where: p.id == ^post_id)
      |> preload(user: [:country, :language])
      |> Repo.one!()

    assert %Country{} = post.user.country
    assert %Language{} = post.user.language
  end

  test "chaining preload nested assocs", %{post_id: post_id} do
    post =
      from(p in Post, as: :post, where: p.id == ^post_id)
      |> preload(user: [:country])
      |> preload(user: [:language])
      |> Repo.one!()

    assert %Country{} = post.user.country
    assert %Language{} = post.user.language
  end

  test "preloading nested joined assocs", %{post_id: post_id} do
    post =
      from(p in Post, as: :post, where: p.id == ^post_id)
      |> join(:inner, [post: p], u in assoc(p, :user), as: :user)
      |> join(:inner, [user: u], c in assoc(u, :country), as: :country)
      |> join(:inner, [user: u], l in assoc(u, :language), as: :language)
      |> preload([user: u, country: c, language: l], user: {u, country: c, language: l})
      |> Repo.one!()

    assert %Country{} = post.user.country
    assert %Language{} = post.user.language
  end

  test "chaining preload nested joined assocs", %{post_id: post_id} do
    post =
      from(p in Post, as: :post, where: p.id == ^post_id)
      |> join(:inner, [post: p], u in assoc(p, :user), as: :user)
      |> join(:inner, [user: u], c in assoc(u, :country), as: :country)
      |> join(:inner, [user: u], l in assoc(u, :language), as: :language)
      |> preload([user: u, country: c], user: {u, country: c})
      |> preload([user: u, language: l], user: {u, language: l})
      |> Repo.one!()

    assert %Language{} = post.user.language
    assert %Country{} = post.user.country
  end
end
