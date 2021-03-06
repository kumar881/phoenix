defmodule <%= module %>ControllerTest do
  use <%= base %>.ConnCase

  alias <%= module %>
  @valid_attrs <%= inspect params %>
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, <%= singular %>_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing <%= plural %>"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, <%= singular %>_path(conn, :new)
    assert html_response(conn, 200) =~ "New <%= singular %>"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, <%= singular %>_path(conn, :create), <%= singular %>: @valid_attrs
    assert redirected_to(conn) == <%= singular %>_path(conn, :index)
    assert Repo.get_by(<%= alias %>, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, <%= singular %>_path(conn, :create), <%= singular %>: @invalid_attrs
    assert html_response(conn, 200) =~ "New <%= singular %>"
  end

  test "shows chosen resource", %{conn: conn} do
    <%= singular %> = Repo.insert %<%= alias %>{}
    conn = get conn, <%= singular %>_path(conn, :show, <%= singular %>)
    assert html_response(conn, 200) =~ "Show <%= singular %>"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, <%= singular %>_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    <%= singular %> = Repo.insert %<%= alias %>{}
    conn = get conn, <%= singular %>_path(conn, :edit, <%= singular %>)
    assert html_response(conn, 200) =~ "Edit <%= singular %>"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    <%= singular %> = Repo.insert %<%= alias %>{}
    conn = put conn, <%= singular %>_path(conn, :update, <%= singular %>), <%= singular %>: @valid_attrs
    assert redirected_to(conn) == <%= singular %>_path(conn, :index)
    assert Repo.get_by(<%= alias %>, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    <%= singular %> = Repo.insert %<%= alias %>{}
    conn = put conn, <%= singular %>_path(conn, :update, <%= singular %>), <%= singular %>: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit <%= singular %>"
  end

  test "deletes chosen resource", %{conn: conn} do
    <%= singular %> = Repo.insert %<%= alias %>{}
    conn = delete conn, <%= singular %>_path(conn, :delete, <%= singular %>)
    assert redirected_to(conn) == <%= singular %>_path(conn, :index)
    refute Repo.get(<%= alias %>, <%= singular %>.id)
  end
end
