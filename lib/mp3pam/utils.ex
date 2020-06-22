defmodule MP3Pam.Utils do
  alias MP3Pam.Repo

  def get_hash(struct) do
    hash = Enum.random(100_000..999_999)

    case Repo.get_by(struct, hash: hash) do
      %struct{} ->
        get_hash(struct)

      nil ->
        hash
    end
  end

  def make_order_by_list(order_by_list) do
    Enum.map(order_by_list, fn %{field: field, order: order} ->
      {String.to_atom(String.downcase(order)), String.to_atom(field)}
    end)
  end

  # def size(size, round \\ 2) do
  #   sizes = [" B", " KB", " MB"]

  #   total = length(sizes) - 1

  #   {new_size, index} =
  #     Enum.reduce(0..total, size, fn i, new_size ->
  #       if total == i do
  #         case new_size < 1024 && i > 0 do
  #           true ->
  #             {new_size, 0}

  #           false ->
  #             {new_size, i}
  #         end
  #       else
  #         if new_size > 1024 && i < total do
  #           new_size / 1024
  #         else
  #           new_size / 1
  #         end
  #       end
  #     end)

  #   Float.to_string(Float.round(new_size, round)) <> Enum.at(sizes, index)
  # end
end
