defmodule FormvalidationWeb.InviteLive do
  use FormvalidationWeb, :live_view
  alias Formvalidation.Invite
  alias Formvalidation.Invite.Recipient

  # Let's use an implicit render/1
  # Create a template file in lib/Formvalidation_web/live/invite_live.html.heex

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:recipient, %Recipient{})
     |> assign_changeset()}
  end

  def assign_changeset(%{assigns: %{recipient: recipient}} = socket) do
    socket

    # change_invitation/2 will use an empty %{} in mount
    |> assign(:changeset, to_form(Invite.change_invitation(recipient)))
  end
end
