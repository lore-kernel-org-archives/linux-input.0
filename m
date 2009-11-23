From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] do not overwrite the first part of phys string
Date: Mon, 23 Nov 2009 08:08:41 -0800
Message-ID: <20091123160841.GA3491@core.coreip.homeip.net>
References: <4B079CE0.60604@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:42451 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600AbZKWQIm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2009 11:08:42 -0500
Content-Disposition: inline
In-Reply-To: <4B079CE0.60604@freemail.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Jiri,

Do you want to split out usbkbd section or do you want me to pick up
everything?

Thanks.

On Sat, Nov 21, 2009 at 08:55:12AM +0100, N=E9meth M=E1rton wrote:
> From: M=E1rton N=E9meth <nm127@freemail.hu>
>=20
> Use strlcat() to append a string to the previously created first part=
=2E
>=20
> Signed-off-by: M=E1rton N=E9meth <nm127@freemail.hu>
> ---
> diff -upr linux-2.6.32-rc7.orig/drivers/hid/usbhid/usbkbd.c linux-2.6=
=2E32-rc7/drivers/hid/usbhid/usbkbd.c
> --- linux-2.6.32-rc7.orig/drivers/hid/usbhid/usbkbd.c	2009-09-10 00:1=
3:59.000000000 +0200
> +++ linux-2.6.32-rc7/drivers/hid/usbhid/usbkbd.c	2009-11-21 08:48:32.=
000000000 +0100
> @@ -266,7 +266,7 @@ static int usb_kbd_probe(struct usb_inte
>  			 le16_to_cpu(dev->descriptor.idProduct));
>=20
>  	usb_make_path(dev, kbd->phys, sizeof(kbd->phys));
> -	strlcpy(kbd->phys, "/input0", sizeof(kbd->phys));
> +	strlcat(kbd->phys, "/input0", sizeof(kbd->phys));
>=20
>  	input_dev->name =3D kbd->name;
>  	input_dev->phys =3D kbd->phys;
> diff -upr linux-2.6.32-rc7.orig/drivers/input/misc/ati_remote.c linux=
-2.6.32-rc7/drivers/input/misc/ati_remote.c
> --- linux-2.6.32-rc7.orig/drivers/input/misc/ati_remote.c	2009-09-10 =
00:13:59.000000000 +0200
> +++ linux-2.6.32-rc7/drivers/input/misc/ati_remote.c	2009-11-21 08:48=
:50.000000000 +0100
> @@ -766,7 +766,7 @@ static int ati_remote_probe(struct usb_i
>  	ati_remote->interface =3D interface;
>=20
>  	usb_make_path(udev, ati_remote->phys, sizeof(ati_remote->phys));
> -	strlcpy(ati_remote->phys, "/input0", sizeof(ati_remote->phys));
> +	strlcat(ati_remote->phys, "/input0", sizeof(ati_remote->phys));
>=20
>  	if (udev->manufacturer)
>  		strlcpy(ati_remote->name, udev->manufacturer, sizeof(ati_remote->n=
ame));
> diff -upr linux-2.6.32-rc7.orig/drivers/input/misc/powermate.c linux-=
2.6.32-rc7/drivers/input/misc/powermate.c
> --- linux-2.6.32-rc7.orig/drivers/input/misc/powermate.c	2009-09-10 0=
0:13:59.000000000 +0200
> +++ linux-2.6.32-rc7/drivers/input/misc/powermate.c	2009-11-21 08:48:=
44.000000000 +0100
> @@ -338,7 +338,7 @@ static int powermate_probe(struct usb_in
>  	pm->input =3D input_dev;
>=20
>  	usb_make_path(udev, pm->phys, sizeof(pm->phys));
> -	strlcpy(pm->phys, "/input0", sizeof(pm->phys));
> +	strlcat(pm->phys, "/input0", sizeof(pm->phys));
>=20
>  	spin_lock_init(&pm->lock);
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
