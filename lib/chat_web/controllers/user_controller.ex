defmodule ChatWeb.UserController do
  use ChatWeb, :controller
  alias Chat.{Repo, User}

  def index(conn, _params) do
    changeset = User.changeset(%User{}, %{})
    user = get_session(conn, :user_id) |> User.find

    render conn, "index.html", changeset: changeset, user: user
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> put_session(:user_id, user.id)
        |> redirect(to: user_path(conn, :index))
      {:error, _} ->
        render conn, "index.html", changeset: changeset
    end

  end
end
