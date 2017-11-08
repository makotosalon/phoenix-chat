defmodule Chat.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chat.{User, Repo}


  schema "users" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def find(id) when is_integer(id), do: User |> Repo.get(id)
  def find(id) when is_nil(id), do: nil
end
