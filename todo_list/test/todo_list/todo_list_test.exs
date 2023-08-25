defmodule TodoListTest do
  use ExUnit.Case
  doctest TodoList

  @file_path "./todo_list.txt"

  test "add" do
    if File.exists?(@file_path) do
      :ok = File.rm(@file_path)
    end

    item_content1 = "Add tests 1"
    {:ok, item} = TodoList.add(item_content1)
    assert item.index == 1
    assert item.item_content == item_content1
    assert item.status == "undone"

    # Todo 项存储在本地文件中
    assert File.read(@file_path) ==
             {:ok, "[{\"index\":1,\"item_content\":\"Add tests 1\",\"status\":\"undone\"}]"}

    # Todo 项索引逐一递增
    item_content2 = "Add tests 2"
    {:ok, item} = TodoList.add(item_content2)
    assert item.index == 2
    assert item.item_content == item_content2
    assert item.status == "undone"

    assert File.read(@file_path) ==
             {:ok,
              "[{\"index\":2,\"item_content\":\"Add tests 2\",\"status\":\"undone\"},{\"index\":1,\"item_content\":\"Add tests 1\",\"status\":\"undone\"}]"}
  end

  test "done" do
    item_content1 = "Add tests 1"
    item_content2 = "Add tests 2"
    {:ok, item1} = TodoList.add(item_content1)
    {:ok, item2} = TodoList.add(item_content2)
    assert item1.status == "undone"
    assert item2.status == "undone"


    {:ok, item1} = TodoList.done(item1)
    assert item1.status == "done"
    assert item2.status == "undone"
  end
end
