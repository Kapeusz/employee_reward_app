defmodule EmployeeRewardApp.Emails do
  import Bamboo.Email
  import Bamboo.Phoenix

  def notification_email(user) do
    base_email()
    |> subject("Received points")
    |> to(user.email)
    |> put_html_layout({EmployeeRewardAppWeb.LayoutView, "email.html"})
    |> assign(:user, user)
    |> render("notify_user.html", title: "Notification", user: user)
  end

  defp base_email() do
    new_email()
    |> from("informator@era.com")
    |> put_html_layout({EmployeeRewardAppWeb.LayoutView, "email.html"})
  end
end
