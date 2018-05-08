defmodule Eblog.GitController do
  use Eblog.Web, :controller

  alias Eblog.Git

  def index(conn, _params) do
    add = Repo.all(Git)
    render(conn, "index.html", add: add)
  end

  def new(conn, _params) do
    changeset = Git.changeset(%Git{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"git" => git_params}) do
    changeset = Git.changeset(%Git{}, git_params)

    case Repo.insert(changeset) do
      {:ok, _git} ->
        conn
        |> put_flash(:info, "Git created successfully.")
        |> redirect(to: git_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    git = Repo.get!(Git, id)
    render(conn, "show.html", git: git)
  end

  def edit(conn, %{"id" => id}) do
    git = Repo.get!(Git, id)
    changeset = Git.changeset(git)
    render(conn, "edit.html", git: git, changeset: changeset)
  end

  def update(conn, %{"id" => id, "git" => git_params}) do
    git = Repo.get!(Git, id)
    changeset = Git.changeset(git, git_params)

    case Repo.update(changeset) do
      {:ok, git} ->
        conn
        |> put_flash(:info, "Git updated successfully.")
        |> redirect(to: git_path(conn, :show, git))
      {:error, changeset} ->
        render(conn, "edit.html", git: git, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    git = Repo.get!(Git, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(git)

    conn
    |> put_flash(:info, "Git deleted successfully.")
    |> redirect(to: git_path(conn, :index))
  end
end
