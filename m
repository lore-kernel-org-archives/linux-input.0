From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/2] elantech: Properly differentiate between clickpads
 and normal touchpads
Date: Mon, 9 Dec 2013 13:02:40 -0500
Message-ID: <CAN+gG=Eh72eBS67db_KNsUzXRNsOUXB8YkzuuHoJca22xRAkdQ@mail.gmail.com>
References: <1386599551-2339-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:46762 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab3LISCl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Dec 2013 13:02:41 -0500
Received: by mail-la0-f46.google.com with SMTP id eh20so1862885lab.19
        for <linux-input@vger.kernel.org>; Mon, 09 Dec 2013 10:02:40 -0800 (PST)
In-Reply-To: <1386599551-2339-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, Duson Lin <dusonlin@emc.com.tw>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Hans,

adding in CC Duson, who seems to be working on the same driver
currently, and Dmitry, the input maintainer.

On Mon, Dec 9, 2013 at 9:32 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> The current assumption in the elantech driver that hw version 3 touchpads are
> never clickpads and hw version 4 touchpads are always clickpads is wrong.
>
> There are several bug reports for this, ie:
> https://bugzilla.redhat.com/show_bug.cgi?id=1030802
> http://superuser.com/questions/619582/right-elantech-touchpad-button-not-working-in-linux
>
> I've spend a couple of hours wading through various bugzillas,
> launchpads and forum posts to create a list of fw-versions and capabilities
> for different laptop models to find a good method to differentiate between
> clickpads and versions with separate hardware buttons.
>
> Which shows that a device being a clickpad is reliable indicated by bit 12
> being set in the fw_version. I've included the gathered list inside the driver,
> so that we've this info at hand if we need to revisit this later.

Duson, can you confirm this? It's not that I don't trust Hans, but if
we could have the hardware maker validating this part, this would be
great.

>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/input/mouse/elantech.c | 43 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 8551dca..f7baa32 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -486,6 +486,7 @@ static void elantech_input_sync_v4(struct psmouse *psmouse)
>         unsigned char *packet = psmouse->packet;
>
>         input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
> +       input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
>         input_mt_report_pointer_emulation(dev, true);
>         input_sync(dev);
>  }
> @@ -984,6 +985,42 @@ static int elantech_get_resolution_v4(struct psmouse *psmouse,
>  }
>
>  /*
> + * Advertise INPUT_PROP_BUTTONPAD for clickpads. The testing of bit 12 in
> + * fw_version for this is based on the following fw_version & caps table:
> + *
> + * Laptop-model:           fw_version:     caps:           buttons:
> + * Acer S3                 0x461f00        10, 13, 0e      clickpad
> + * Acer S7-392             0x581f01        50, 17, 0d      clickpad
> + * Acer V5-131             0x461f02        01, 16, 0c      clickpad
> + * Acer V5-551             0x461f00        ?               clickpad
> + * Asus K53SV              0x450f01        78, 15, 0c      2 hw buttons
> + * Asus G46VW              0x460f02        00, 18, 0c      2 hw buttons
> + * Asus G750JX             0x360f00        00, 16, 0c      2 hw buttons
> + * Asus UX31               0x361f00        20, 15, 0e      clickpad
> + * Asus UX32VD             0x361f02        00, 15, 0e      clickpad
> + * Avatar AVIU-145A2       0x361f00        ?               clickpad
> + * Gigabyte U2442          0x450f01        58, 17, 0c      2 hw buttons
> + * Lenovo L430             0x350f02        b9, 15, 0c      2 hw buttons (*)
> + * Samsung NF210           0x150b00        78, 14, 0a      2 hw buttons
> + * Samsung NP770Z5E        0x575f01        10, 15, 0f      clickpad
> + * Samsung NP700Z5B        0x361f06        21, 15, 0f      clickpad
> + * Samsung NP900X3E-A02    0x575f03        ?               clickpad
> + * Samsung NP-QX410        0x851b00        19, 14, 0c      clickpad
> + * Samsung RC512           0x450f00        08, 15, 0c      2 hw buttons
> + * Samsung RF710           0x450f00        ?               2 hw buttons
> + * System76 Pangolin       0x250f01        ?               2 hw buttons
> + * (*) + 3 trackpoint buttons
> + */
> +static void elantech_set_buttonpad_prop(struct psmouse *psmouse)
> +{
> +       struct input_dev *dev = psmouse->dev;
> +       struct elantech_data *etd = psmouse->private;
> +
> +       if (etd->fw_version & 0x001000)
> +               __set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);

Small question here: if the touchpad is a clickpad, should'nt we also
remove the BTN_RIGHT bit too?

Cheers,
Benjamin

> +}
> +
> +/*
>   * Set the appropriate event bits for the input subsystem
>   */
>  static int elantech_set_input_params(struct psmouse *psmouse)
> @@ -1026,6 +1063,8 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>                 __set_bit(INPUT_PROP_SEMI_MT, dev->propbit);
>                 /* fall through */
>         case 3:
> +               if (etd->hw_version == 3)
> +                       elantech_set_buttonpad_prop(psmouse);
>                 input_set_abs_params(dev, ABS_X, x_min, x_max, 0, 0);
>                 input_set_abs_params(dev, ABS_Y, y_min, y_max, 0, 0);
>                 if (etd->reports_pressure) {
> @@ -1047,9 +1086,7 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>                          */
>                         psmouse_warn(psmouse, "couldn't query resolution data.\n");
>                 }
> -               /* v4 is clickpad, with only one button. */
> -               __set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
> -               __clear_bit(BTN_RIGHT, dev->keybit);
> +               elantech_set_buttonpad_prop(psmouse);
>                 __set_bit(BTN_TOOL_QUADTAP, dev->keybit);
>                 /* For X to recognize me as touchpad. */
>                 input_set_abs_params(dev, ABS_X, x_min, x_max, 0, 0);
> --
> 1.8.4.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
