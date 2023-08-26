defmodule LoginTest do
  use ExUnit.Case
  doctest TodoList

  @user_config_file_path ".todo-config"

  # One-arity function name
  # setup_all :clean_up_users

  def clean_up_users(_context) do
    if File.exists?(@user_config_file_path) do
      :ok = File.rm(@user_config_file_path)
    end

    :ok
  end

  setup :clean_up_users

  test "login success" do
    {:ok, user} = User.add("test_user1", "123456")
    assert user.name == "test_user1"
    assert user.login == false

    {:ok, user} = Login.login("test_user1")
    assert user.name == "test_user1"
    assert user.login == true

    # 当前用户信息存储在配置文件中 ~/.todo-config
    {:ok, file_content} = File.read(@user_config_file_path)

    file_content
    |> Jason.decode!()
    |> AtomizeKeys.atomize_string_keys()
    |> Enum.find(fn user -> user.name == "test_user1" end)

    assert user.name == "test_user1"
    assert user.login == true
  end

  setup :clean_up_users
  test "login failed: user not exist" do
    assert {:error, "user not exist"} = Login.login("test_user1")
  end

  test "login failed: wrong pwd"
  test "login failed: user is already logged in"

  test "logout success"
  test "logout failed: user has not logged in"
end
