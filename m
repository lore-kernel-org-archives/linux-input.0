From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 1/3] picolcd: driver for PicoLCD HID device
Date: Thu, 25 Feb 2010 12:07:38 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002251201430.30967@pobox.suse.cz>
References: <20100221002001.0a7e05a7@neptune.home> <20100224170049.0d04af3c@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100224170049.0d04af3c-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rick L. Vinyard Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>, Nicu Pavel <npavel-VxACSXvuqMTQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 24 Feb 2010, Bruno Pr=C3=A9mont wrote:

> +config HID_PICOLCD
> +	tristate "Minibox PicoLCD (graphic version)"
> +	depends on FB
> +	select FB_DEFERRED_IO
> +	select FB_SYS_FILLRECT
> +	select FB_SYS_COPYAREA
> +	select FB_SYS_IMAGEBLIT
> +	select FB_SYS_FOPS
> +	select BACKLIGHT_LCD_SUPPORT
> +	select BACKLIGHT_CLASS_DEVICE
> +	select LCD_CLASS_DEVICE

I guess you need dependency on USB_HID as well, right?

> --- a/drivers/hid/hid-picolcd.c
> +++ b/drivers/hid/hid-picolcd.c
> @@ -0,0 +1,1075 @@
> +/*******************************************************************=
********
> + *   Copyright (C) 2010 by Bruno Pr=C3=A9mont <bonbons@linux-vserver=
=2Eorg>       *
> + *                                                                  =
       *
> + *   Based on Logitech G13 driver (v0.4)                            =
       *
> + *     Copyright (C) 2009 by Rick L. Vinyard, Jr. <rvinyard-qcTL/1vZYtg@public.gmane.org=
edu>   *
> + *                                                                  =
       *
> + *   This program is free software: you can redistribute it and/or m=
odify  *
> + *   it under the terms of the GNU General Public License as publish=
ed by  *
> + *   the Free Software Foundation, either version 2 of the License. =
       *

I support removing the 'or any later' clause, but I think your version =
has=20
the grammar wrong :)


> +/* Update fb_vbitmap from the screen_base and send changed tiles to =
device */
> +static void picolcd_fb_update(struct picolcd_data *data)
> +{
> +	int chip, tile;
> +
> +	spin_lock(&data->lock);
> +	if (!(data->status & PICOLCD_READY_FB)) {
> +		spin_unlock(&data->lock);
> +		picolcd_fb_reset(data->hdev, 0);
> +	} else
> +		spin_unlock(&data->lock);

Please put the brackets to the else branch as well.

Also, it'd be great if the framebuffer part would get Ack from someone=20
more familiar with framebuffer code than me.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
