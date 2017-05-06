defmodule Broccoli.GuardianSerializer do
  @behaviour Guardian.Serializer

  def for_token(id), do: {:ok, id}
  def from_token(id), do: {:ok, id}
end
