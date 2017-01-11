defmodule Kaggle do

  def doit do
    data = open_file
    train_data(data)
  end

  def open_file do 
    File.stream!("./winequality-data.csv") |> CSV.decode(headers: true) |> Enum.to_list
  end

  def train_data(data) do
    bayes = SimpleBayes.init()
    IO.puts("starting loop")
    Enum.each(data, fn(d) -> 
      id = Map.get(d, "id")
      IO.puts("row for id #{id}")
      keys = Map.keys(d)
      keys = Enum.filter(keys, fn(x) -> x != "id" end)
      train(bayes, id, keys, d)
    end)
    IO.puts("end loop")
    bayes
  end

  def train(bayes_pid, id, [h | []], map) do
    IO.puts("last column for this row")
    SimpleBayes.train(
      bayes_pid,
      id,
      "#{h} #{Map.get(map, h)}")
  end

  def train(bayes_pid, id, [h | t] = keys, map) do
    IO.puts("#{Enum.count(keys)} columns left")
    SimpleBayes.train(
      bayes_pid,
      id,
      "#{h} #{Map.get(map, h)}")
    train(bayes_pid, id, t, map)
  end
end
