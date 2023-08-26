defmodule Login do
  @user_config_file_path ".todo-config"
  @storage_location :file

  def login(user_name, pwd) do
    user = User.get(user_name)

    cond do
      is_nil(user) ->
        {:error, "user not exist"}

      user.pwd != pwd ->
        {:error, "wrong pwd"}

      true ->
        user = Map.put(user, :login, true)
        save_updated_user(user)
        {:ok, user}
    end
  end

  def logout() do
    user = get_login_user()

    if is_nil(user) do
      {:error, "user not login"}
    else
      user = Map.put(user, :login, false)
      save_updated_user(user)
      {:ok, user}
    end
  end

  defp get_login_user() do
    User.all_users()
    |> IO.inspect(label: "all_users")
    |> Enum.find(&(&1.login == true))
  end

  defp save_updated_user(user) do
    file_content =
      User.all_users()
      |> Enum.reject(&(&1.name == user.name))
      |> List.insert_at(0, user)
      |> Jason.encode!()

    :ok = File.write(@user_config_file_path, file_content)
  end

  def logout() do
  end
end
