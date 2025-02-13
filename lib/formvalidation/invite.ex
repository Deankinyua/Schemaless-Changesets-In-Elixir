defmodule Formvalidation.Invite do
  alias Formvalidation.Invite.Recipient

  def change_invitation(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  def send_invite(recipient, attrs) do
    dbg(Recipient.changeset(recipient, attrs))
    # send email to promo recipient
  end
end
