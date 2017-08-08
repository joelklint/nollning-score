defmodule NollningScore.ScoreController do
  use NollningScore.Web, :controller

  alias NollningScore.Score
  alias NollningScore.Category

  def index(conn, %{"event_id" => event_id}) do

    score = from(
      s in Score,
      join: c in Category, on: s.category_id == c.id,
      where: c.event_id == ^event_id,
    )
    |> Repo.all()
    |> Repo.preload([:category, :guild])

    conn |> render("index.json", score: score, relations: [:category, :guild])
  end

  def create(conn, %{"score" => score_params, "category_id" => category_id}) do
    params = score_params 
    |> Map.take(["value", "guild_id"]) 
    |> Map.put("category_id", category_id)
    
    result = 
      case Repo.get_by(Score, category_id: params["category_id"], guild_id: params["guild_id"]) do
        nil -> %Score{}
        score -> score
      end
      |> Score.changeset(params)
      |> Repo.insert_or_update
    
    case result do
      {:ok, score} ->
        score = Repo.preload(score, [:category, :guild])
        conn
        |> put_status(201)
        |> render("show.json", score: score, relations: [:category, :guild])
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render(NollningScore.ChangesetView, "error.json", changeset: changeset)
    end

  end

end
