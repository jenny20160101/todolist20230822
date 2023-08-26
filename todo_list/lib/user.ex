defmodule User do
  @user_config_file_path ".todo-config"
  @storage_location :file

  def add(user_name, pwd) do
    if get(user_name) do
      {:error, "user already exist"}
    else
      user = %{
        name: user_name,
        pwd: pwd,
        login: false
      }

      save_new_user(user, :file)

      {:ok, user}
    end
  end

  defp save_new_user(new_user, :file) do
    exist_users = all_users()

    new_users =
      exist_users
      |> List.insert_at(length(exist_users), new_user)
      |> Jason.encode!()

    :ok = File.write(@user_config_file_path, new_users)
  end

  def get(user_name) do
    case @storage_location do
      :file ->
        all_users()
        |> Enum.find(fn user -> user.name == user_name end)
    end
  end

  def all_users() do
    TodoList.file_content(@user_config_file_path)
    |> Jason.decode!()
    |> AtomizeKeys.atomize_string_keys()
  end
end
