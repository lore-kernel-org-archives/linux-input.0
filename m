From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Input: synaptics - handle spurious release of trackstick
 buttons, again
Date: Tue, 15 Mar 2016 15:25:40 +0100
Message-ID: <CAN+gG=H+n5fcUw2isArFu04VPdyQ7UmzWzU8-jOVRefnzR_69Q@mail.gmail.com>
References: <1458037097-6444-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35821 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbcCOOZl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2016 10:25:41 -0400
In-Reply-To: <1458037097-6444-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Mar 15, 2016 at 11:18 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Looks like the fimware 8.2 stall has the extra buttons spurious release

Typo: *still, not stall. (sorry)

Cheers,
Benjamin

> bug.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=114321
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/input/mouse/synaptics.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 6025eb4..9f3b83f 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -862,8 +862,9 @@ static void synaptics_report_ext_buttons(struct psmouse *psmouse,
>         if (!SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
>                 return;
>
> -       /* Bug in FW 8.1, buttons are reported only when ExtBit is 1 */
> -       if (SYN_ID_FULL(priv->identity) == 0x801 &&
> +       /* Bug in FW 8.1 & 8.2, buttons are reported only when ExtBit is 1 */
> +       if (((SYN_ID_FULL(priv->identity) == 0x801) ||
> +            (SYN_ID_FULL(priv->identity) == 0x802)) &&
>             !((psmouse->packet[0] ^ psmouse->packet[3]) & 0x02))
>                 return;
>
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
