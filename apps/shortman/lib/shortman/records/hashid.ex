defmodule Shortman.Records.Hashid do
  @doc false
  defp new() do
    Hashids.new(
      salt: Application.get_env(:shortman, :hashid_salt),
      min_len: 10,
      alphabet: "ABCDEFGHJKLMNPQRSTUVQXYZ23456789abcdefghjkmnopqrstuvwxyz"
    )
  end

  @doc false
  def encode(number) do
    Hashids.encode(new(), number)
  end

  @doc false
  def decode(hashid) do
    Hashids.decode(new(), hashid)
  end
end
