From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [Patch] hid: enhance hid-saitek for use with R.A.T.5 and
 similar
Date: Tue, 26 Jan 2016 15:29:38 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601261527260.21446@cbobk.fhfr.pm>
References: <5690FEB0.4040809@unet.univie.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54715 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965877AbcAZO3k (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jan 2016 09:29:40 -0500
In-Reply-To: <5690FEB0.4040809@unet.univie.ac.at>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Piotr Sawuk <a9702387@unet.univie.ac.at>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 9 Jan 2016, Piotr Sawuk wrote:

> added support for my pid so I can test the changes:
> 3 events were mapped to one, this allows discerning which is which.
> on my mouse there is a button with a 3 colour-led.
> I can now determine in user-space which colour is visible.
> this patch replaces my previous one which merely added rat5-support.
>=20
> Signed-off-by: Piotr Sawuk <piotr5@users.sf.net>

The patch has been damaged by your mail client, and as such can't be=20
applied. Could you please fix that up and resend?

> ---
> add support for mad catz r.a.t.5
> add a file in sysfs called "mode" exposing the integer of that name.
>=20
> diff -rup linux-4.2.6-gentoo/drivers/hid/hid-core.c
> linux-4.2.6-gentoo-rat5/drivers/hid/hid-core.c
> --- linux-4.2.6-gentoo/drivers/hid/hid-core.c	2015-08-30
> 20:34:09.000000000 +0200
> +++ linux-4.2.6-gentoo-rat5/drivers/hid/hid-core.c	2015-12-30
> 12:09:14.340841552 +0100
> @@ -1959,6 +1959,7 @@ static const struct hid_device_id hid_ha
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7) }=
,
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_MMO7) }=
,
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT9)=
 },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT5)=
 },

Could you please keep the list sorted (at least by parts)?

>  #endif
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG,
> USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG,
> USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
> diff -rup linux-4.2.6-gentoo/drivers/hid/hid-ids.h
> linux-4.2.6-gentoo-rat5/drivers/hid/hid-ids.h
> --- linux-4.2.6-gentoo/drivers/hid/hid-ids.h	2015-08-30
> 20:34:09.000000000 +0200
> +++ linux-4.2.6-gentoo-rat5/drivers/hid/hid-ids.h	2015-12-29
> 18:47:36.756225217 +0100
> @@ -634,6 +634,7 @@
>=20
>  #define USB_VENDOR_ID_MADCATZ		0x0738
>  #define USB_DEVICE_ID_MADCATZ_BEATPAD	0x4540
> +#define USB_DEVICE_ID_MADCATZ_RAT5	0x1705
>  #define USB_DEVICE_ID_MADCATZ_RAT9	0x1709
>=20
>  #define USB_VENDOR_ID_MCC		0x09db
> diff -rup linux-4.2.6-gentoo/drivers/hid/hid-saitek.c
> linux-4.2.6-gentoo-rat5/drivers/hid/hid-saitek.c
> --- linux-4.2.6-gentoo/drivers/hid/hid-saitek.c	2015-08-30
> 20:34:09.000000000 +0200
> +++ linux-4.2.6-gentoo-rat5/drivers/hid/hid-saitek.c	2016-01-09
> 12:19:19.574905612 +0100
> @@ -7,10 +7,11 @@
>   *  (This module is based on "hid-ortek".)
>   *  Copyright (c) 2012 Andreas H=C3=BCbner
>   *
> - *  R.A.T.7, R.A.T.9, M.M.O.7 (USB gaming mice):
> + *  R.A.T.5, R.A.T.7, R.A.T.9, M.M.O.7 (USB gaming mice):
>   *  Fixes the mode button which cycles through three constantly pres=
sed
>   *  buttons. All three press events are mapped to one button and the
>   *  missing release event is generated immediately.
> + *  Original press event is available in "mode" file on sysfs.
>   *
>   */
>=20
> @@ -37,6 +38,40 @@ struct saitek_sc {
>  	int mode;
>  };
>=20
> +static ssize_t show_mode(struct device *dev,
> +		struct device_attribute *attr,
> +		char *mode_buf);
> +
> +/* world-readable since errors are caught and no usb-interaction nee=
ded. */
> +DEVICE_ATTR(mode, 0444, show_mode, NULL);
> +
> +static ssize_t show_mode(struct device *dev,
> +		struct device_attribute *attr,
> +		char *mode_buf)
> +{
> +	struct saitek_sc *ssc;
> +	struct hid_device *hdev;
> +
> +	/* error-messages in sysfs file since it's non-critical. */
> +	if (dev =3D=3D NULL) {
> +		return snprintf(mode_buf, PAGE_SIZE, "No parent.\n");
> +	}
> +
> +	hdev =3D container_of(dev, struct hid_device, dev);

You can use to_hid_device() here.

Thanks,

--=20
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
