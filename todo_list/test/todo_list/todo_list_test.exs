defmodule TodoListTest do
  use ExUnit.Case
  doctest TodoList

  @file_path "./todo_list.txt"

  # One-arity function name
  # setup_all :clean_up_file_content

  def clean_up_file_content(_context) do
    if File.exists?(@file_path) do
      :ok = File.rm(@file_path)
    end

    :ok
  end

  setup :clean_up_file_content

  test "add" do
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
              "[{\"index\":1,\"item_content\":\"Add tests 1\",\"status\":\"undone\"},{\"index\":2,\"item_content\":\"Add tests 2\",\"status\":\"undone\"}]"}
  end

  setup :clean_up_file_content

  test "done:succeed" do
    item_content1 = "Add tests 1"
    item_content2 = "Add tests 2"
    {:ok, item1} = TodoList.add(item_content1)
    {:ok, item2} = TodoList.add(item_content2)
    assert item1.status == "undone"
    assert item2.status == "undone"
    assert item1.index == 1

    {:ok, item1} = TodoList.done(1)
    assert item1.status == "done"
    assert item1.index == 1
    assert item2.status == "undone"

    {:ok, item2} = TodoList.done(+2)
    assert item1.status == "done"
    assert item2.status == "done"
  end

  test "done:index not exist" do
    {:ok, _} = TodoList.add("item_content1")
    assert {:error, "Item <10> not found."} == TodoList.done(10)
    assert {:error, "Item <-10> not found."} == TodoList.done(-10)
  end

  test "done:index is not integer" do
    assert {:error, "10acbd is not integer."} == TodoList.done("10acbd")
  end

  setup :clean_up_file_content

  test "list items" do
    item_content1 = "Add tests 1"
    item_content2 = "Add tests 2"
    item_content3 = "Add tests 3"
    {:ok, item1} = TodoList.add(item_content1)
    {:ok, item2} = TodoList.add(item_content2)
    {:ok, item3} = TodoList.add(item_content3)
    {:ok, item1} = TodoList.done(item1.index)
    assert item1.status == "done"
    assert item2.status == "undone"
    assert item3.status == "undone"

    assert TodoList.list() == [item2, item3]
  end

  setup :clean_up_file_content

  test "list items include done items" do
    item_content1 = "Add tests 1"
    item_content2 = "Add tests 2"
    item_content3 = "Add tests 3"
    {:ok, item1} = TodoList.add(item_content1)
    {:ok, item2} = TodoList.add(item_content2)
    {:ok, item3} = TodoList.add(item_content3)
    {:ok, item1} = TodoList.done(item1.index)
    assert item1.status == "done"
    assert item2.status == "undone"
    assert item3.status == "undone"

    assert TodoList.list(:all) == [item1, item2, item3]
  end
end
