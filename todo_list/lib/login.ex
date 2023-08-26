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

  defp save_updated_user(user) do
    User.all_users()
    |> Enum.reject(&(&1.name == user.name))
    |> List.insert_at(0, user)
    |> Jason.encode!()
    |> File.write(@user_config_file_path)
  end

  def logout() do
  end
end
