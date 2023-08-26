defmodule Login do
  @user_config_file_path ".todo-config"
  @storage_location :file

  def login(user_name) do
    case User.get(user_name) do
      nil ->
        {:error, "user not exist"}

      user ->
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
