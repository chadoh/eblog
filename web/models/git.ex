defmodule Eblog.Git do
  use Eblog.Web, :model

  schema "add" do
    field :., :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:.])
    |> validate_required([:.])
  end
end
