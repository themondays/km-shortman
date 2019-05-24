defmodule ShortmanRecordsTest do
  use ExUnit.Case
  test "cache test" do
    dataset =%{id: 1, url: "https://google.com"}
  
    assert Shortman.Records.Cache.fetch("A", fn ->
      dataset
    end) == dataset

    assert Shortman.Records.Cache.fetch("A", fn -> "" end) == dataset 
  end
end
