defmodule ChatWeb.UserController do
  use ChatWeb, :controller
  alias Chat.{Repo, User}

  def index(conn, _params) do
    changeset = User.changeset(%User{}, %{})
    render conn, "index.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :index))
      {:error, _} ->
        render conn, "index.html", changeset: changeset
    end
  end
end
