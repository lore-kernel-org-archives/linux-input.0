From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 3/5] Input: synaptics - Query min dimensions when safe firmware
Date: Thu, 29 Jan 2015 13:48:06 -0500
Message-ID: <CAN+gG=FqhKf1khX4bhtpsRAm2x62LP1PwkFkGFmu32TBMCd7yA@mail.gmail.com>
References: <1421945201-1528-1-git-send-email-daniel.martin@secunet.com>
	<1422347645-5194-1-git-send-email-daniel.martin@secunet.com>
	<1422347645-5194-4-git-send-email-daniel.martin@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:40936 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbbA2SsH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2015 13:48:07 -0500
Received: by mail-qg0-f41.google.com with SMTP id q108so32400604qgd.0
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2015 10:48:06 -0800 (PST)
In-Reply-To: <1422347645-5194-4-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Martin <consume.noise@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>

Hi Daniel,

in one hand I would like to see that upstream ASAP. But on the other
hand, I have some concerns here and there regarding this series.

On Tue, Jan 27, 2015 at 3:34 AM, Daniel Martin
<daniel.martin@secunet.com> wrote:
> From: Daniel Martin <consume.noise@gmail.com>
>
> Query the min dimensions even if the check
>     SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7
> fails, but we know that the firmware version is safe. Atm. this is
> version 8.1 only.
>
> With that we don't need quirks for post-2013 models anymore as they
> expose correct min and max dimensions.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=91541
> Signed-off-by: Daniel Martin <consume.noise@gmail.com>
> ---
>  drivers/input/mouse/synaptics.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 7a78d75..37d4dff 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -333,6 +333,30 @@ static int synaptics_identify(struct psmouse *psmouse)
>         return -1;
>  }
>
> +struct fw_version {
> +       unsigned char major;
> +       unsigned char minor;
> +};
> +
> +static const struct fw_version safe_fw_list[] = {
> +       {8, 1}, /* safe for SYN_QUE_EXT_MIN_COORDS */
> +       { }
> +};
> +
> +static bool synaptics_is_safe_fw(struct psmouse *psmouse)
> +{
> +       struct synaptics_data *priv = psmouse->private;
> +       int i;
> +
> +       for (i = 0; safe_fw_list[i].major; i++) {
> +               if (safe_fw_list[i].major == SYN_ID_MAJOR(priv->identity) &&
> +                   safe_fw_list[i].minor == SYN_ID_MINOR(priv->identity))
> +                       return true;
> +       }
> +
> +       return false;
> +}

This seems a little bit too much for just one firmware ID.
Plus the name safe_fw_list gives hope that this list can be used for
something else later, but then it may conflict with it current
purpose.

How about we just rely on the current list of PNPIDs we already have
for this generation?
This might not be a good idea either, so an other solution would be to
directly check for firmware 8.1 in the test below.

I'd like to hear other opinions on this however before we commit to a decision.


Cheers,
Benjamin

PS: I think Hans already mentioned, but if you want your patches to
land in Dmitry's tree, it's better to CC him directly when submitting
a patch.

> +
>  /*
>   * Read touchpad resolution and maximum reported coordinates
>   * Resolution is left zero if touchpad does not support the query
> @@ -368,7 +392,8 @@ static int synaptics_resolution(struct psmouse *psmouse)
>                 }
>         }
>
> -       if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 &&
> +       if ((SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 ||
> +            synaptics_is_safe_fw(psmouse)) &&
>             SYN_CAP_MIN_DIMENSIONS(priv->ext_cap_0c)) {
>                 if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_MIN_COORDS, resp)) {
>                         psmouse_warn(psmouse,
> --
> 2.2.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
