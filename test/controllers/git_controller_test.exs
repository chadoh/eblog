defmodule Eblog.GitControllerTest do
  use Eblog.ConnCase

  alias Eblog.Git
  @valid_attrs %{.: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, git_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing add"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, git_path(conn, :new)
    assert html_response(conn, 200) =~ "New git"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, git_path(conn, :create), git: @valid_attrs
    assert redirected_to(conn) == git_path(conn, :index)
    assert Repo.get_by(Git, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, git_path(conn, :create), git: @invalid_attrs
    assert html_response(conn, 200) =~ "New git"
  end

  test "shows chosen resource", %{conn: conn} do
    git = Repo.insert! %Git{}
    conn = get conn, git_path(conn, :show, git)
    assert html_response(conn, 200) =~ "Show git"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, git_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    git = Repo.insert! %Git{}
    conn = get conn, git_path(conn, :edit, git)
    assert html_response(conn, 200) =~ "Edit git"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    git = Repo.insert! %Git{}
    conn = put conn, git_path(conn, :update, git), git: @valid_attrs
    assert redirected_to(conn) == git_path(conn, :show, git)
    assert Repo.get_by(Git, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    git = Repo.insert! %Git{}
    conn = put conn, git_path(conn, :update, git), git: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit git"
  end

  test "deletes chosen resource", %{conn: conn} do
    git = Repo.insert! %Git{}
    conn = delete conn, git_path(conn, :delete, git)
    assert redirected_to(conn) == git_path(conn, :index)
    refute Repo.get(Git, git.id)
  end
end
