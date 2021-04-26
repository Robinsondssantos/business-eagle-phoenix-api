defmodule Api.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    # Virtual field
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:name, min: 3, max: 50)
    |> validate_length(:password, min: 6, max: 30)
    |> unique_constraint(:email)
  end

  # https://medium.com/@njwest/jwt-auth-with-an-elixir-on-phoenix-1-3-guardian-api-and-react-native-mobile-app-1bd00559ea51
  # defp put_password_hash(changeset) do
  #   case changeset do
  #     %Ecto.Changeset{valid?: true, changes: %{password: pass}}
  #     ->
  #       put_change(changeset, :password_hash, Comeon)
  #   end
  # end
end
