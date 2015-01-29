From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 4/5] Input: synaptics - Skip quirks when post-2013 dimensions
Date: Thu, 29 Jan 2015 14:02:23 -0500
Message-ID: <CAN+gG=HgJr6T3cTewx0=vVGmhS0SfufjtaU97fe+kCmharvZXA@mail.gmail.com>
References: <1421945201-1528-1-git-send-email-daniel.martin@secunet.com>
	<1422347645-5194-1-git-send-email-daniel.martin@secunet.com>
	<1422347645-5194-5-git-send-email-daniel.martin@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:57417 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248AbbA2TCY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2015 14:02:24 -0500
Received: by mail-qg0-f50.google.com with SMTP id f51so32609507qge.9
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2015 11:02:23 -0800 (PST)
In-Reply-To: <1422347645-5194-5-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Martin <consume.noise@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Peter Hutterer <peter.hutterer@who-t.net>

Hi Daniel,

On Tue, Jan 27, 2015 at 3:34 AM, Daniel Martin
<daniel.martin@secunet.com> wrote:
> From: Daniel Martin <consume.noise@gmail.com>
>
> If we queried min/max dimensions of x [1266..5674], y [1170..4684] we
> have post-2013 model and don't need to apply any quirk.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=91541
> Signed-off-by: Daniel Martin <consume.noise@gmail.com>
> ---
>  drivers/input/mouse/synaptics.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 37d4dff..f6c43ff 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -420,6 +420,11 @@ static int synaptics_quirks(struct psmouse *psmouse)
>         struct synaptics_data *priv = psmouse->private;
>         int i;
>
> +       /* Post-2013 models expose correct dimensions. */
> +       if (priv->x_min == 1266 && priv->x_max == 5674 &&
> +           priv->y_min == 1170 && priv->y_max == 4684)
> +               return 0;
> +

Well, this one, I don't like it either :(

At least, the test should be within the psmouse_matches_pnp_id() below
to ensure we are deciding with Lenovo devices only.

The other concern is hardcoding these values in the code directly.
What if Synaptics/Lenovo decides to ship a new released model with
proper min_max ranges but with a different offset?

Andrew told us that the board ID should be enough to discriminate old
and faulty touchpads from the new and valid touchpads.

My concern here is that we will have to backport these changes in the
various stable kernel and the various distributions. And if we do not
end up with the right solution right now, that means that we will have
to do the job over and over.

I am quite tempted to find a solution in the userspace for that fix.
Not sure I'll be able to find the right one right now, but it may
worth trying.

Cheers,
Benjamin

>         for (i = 0; min_max_pnpid_table[i].pnp_ids; i++) {
>                 if (psmouse_matches_pnp_id(psmouse,
>                                            min_max_pnpid_table[i].pnp_ids)) {
> --
> 2.2.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
