defmodule ElixirFriends.PostView do
  use ElixirFriends.Web, :view
  @total_links 10

  def pagination_links(paginator) do
    links = page_numbers(paginator)
            |> Enum.map(&page_link/1)
    content_tag(:ul, links)
  end

  def page_numbers(paginator) do
    page_numbers = (paginator.page_number..paginator.total_pages)
                   |> Enum.to_list

    if(paginator.page_number !== 1) do
      page_numbers = [{"<<", paginator.page_number - 1}, 1] ++ page_numbers
    end

    page_numbers = Enum.take(page_numbers, @total_links)

    if(paginator.page_number !== paginator.total_pages) do
      page_numbers = page_numbers ++ [paginator.total_pages, {">>", paginator.page_number + 1}]
    end

    page_numbers
  end

  def page_link({text, page_number}) do
    content_tag(:li, link("#{text}", [to: "?page=#{page_number}"]))
  end
  def page_link(page_number) do
    content_tag(:li, link("#{page_number}", [to: "?page=#{page_number}"]))
  end
end
