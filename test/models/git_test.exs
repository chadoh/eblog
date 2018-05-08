defmodule Eblog.GitTest do
  use Eblog.ModelCase

  alias Eblog.Git

  @valid_attrs %{.: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Git.changeset(%Git{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Git.changeset(%Git{}, @invalid_attrs)
    refute changeset.valid?
  end
end
