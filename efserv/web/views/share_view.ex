defmodule Efserv.ShareView do
  use Efserv.Web, :view

  def render("index.json", %{shares: shares}) do
    %{data: render_many(shares, Efserv.ShareView, "share.json")}
  end

  def render("show.json", %{share: share}) do
    %{data: render_one(share, Efserv.ShareView, "share.json")}
  end

  def render("share.json", %{share: share}) do
    %{id: share.id,
      user_id: share.user_id,
      name: share.name}
  end
end
