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
     |> assign_changeset()
     |> assign(message: "")}
  end

  def assign_changeset(%{assigns: %{recipient: recipient}} = socket) do
    socket

    # change_invitation/2 will use an empty %{} in mount
    |> assign(:changeset, to_form(Invite.change_invitation(recipient)))
  end

  # lib/arcade_web/live/invite_live.ex
  def handle_event(
        "validate",
        %{"recipient" => recipient_params},
        %{assigns: %{recipient: recipient}} = socket
      ) do
    changeset =
      recipient
      |> Invite.change_invitation(recipient_params)
      # * we use Map.put(:action, :validate) to add the validate
      # * action to the changeset, a signal that instructs Phoenix to display errors.

      |> Map.put(:action, :validate)

    {:noreply,
     socket
     |> assign(:changeset, to_form(changeset))}
  end

  def handle_event(
        "save",
        %{"recipient" => _recipient_params},
        %{assigns: %{changeset: changeset}} = socket
      ) do
    cond do
      changeset.source.valid? == false ->
        {:noreply,
         socket
         |> assign(:message, "Email Not Sent")
         |> assign(:changeset, changeset)}

      true ->
        {:noreply,
         socket
         |> assign(:message, "Email Sent")
         |> assign_changeset()}
    end
  end
end
