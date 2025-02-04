defmodule Formvalidation.Invite.Recipient do
  # ? Where we have our changesets is the core
  defstruct [:name, :email]

  # * we need to give our module awareness of the types
  # * that will be considered valid by any changeset we create.

  @types %{game_name: :string, email: :string}

  alias Formvalidation.Invite.Recipient
  import Ecto.Changeset

  def changeset(%Recipient{} = invitation, attrs) do
    # * cast(data, params, permitted, opts \\ [])
    # *data may be either a changeset, a schema struct or a {data, types} tuple.
    # * Since we are using schemaless validation we have to use {data, types} option
    # *Map.keys will return a list of atom keys extracted from @types

    {invitation, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_required([:game_name, :email])
    |> validate_format(:email, ~r/@/)
  end
end
