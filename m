From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] Added support for the Wacom Bamboo Pen (CTL-660/K)
Date: Sat, 9 Jul 2011 15:44:40 -0500
Message-ID: <CAGzDe_bOZMUBrB8tJz8r9Aa=PMvhuCSsVjyvP=2-3MfusdRBRw@mail.gmail.com>
References: <1310195678-22685-1-git-send-email-me@gbraad.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48963 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459Ab1GIUol convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 Jul 2011 16:44:41 -0400
Received: by iwn6 with SMTP id 6so2648102iwn.19
        for <linux-input@vger.kernel.org>; Sat, 09 Jul 2011 13:44:41 -0700 (PDT)
In-Reply-To: <1310195678-22685-1-git-send-email-me@gbraad.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gerard Braad <me@gbraad.nl>
Cc: linux-input@vger.kernel.org

On Sat, Jul 9, 2011 at 2:14 AM, Gerard Braad <me@gbraad.nl> wrote:
> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 08ba5ad..23c9a40 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1460,6 +1460,9 @@ static const struct wacom_features wacom_featur=
es_0xD3 =3D
> =A0static const struct wacom_features wacom_features_0xD4 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo Pen", =A0 =A0 WACOM_PKGLEN_BBFUN, =A0 =
=A0 14720, =A09200, =A0255,
> =A0 =A0 =A0 =A0 =A063, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES =
};
> +static const struct wacom_features wacom_features_0xD5 =3D
> + =A0 =A0 =A0 { "Wacom Bamboo Pen", =A0 =A0 WACOM_PKGLEN_BBFUN, =A0 =A0=
 21648, 13530, 1023,
> + =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xD6 =3D
> =A0 =A0 =A0 =A0{ "Wacom BambooPT 2FG 4x5", WACOM_PKGLEN_BBFUN, =A0 14=
720, =A09200, 1023,
> =A0 =A0 =A0 =A0 =A063, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES =
};

There is kinda a convention in other Bamboo names to show the tablet
size when multiple sizes exist.  Since it has the same max's as 0xD3,
it looks like this this new pen-only 0xD5 should have "6X8" at end of
its name.

Now that we advertise the resolution with ABS_X/ABS_Y, its not all
that useful of a convention any more.

With or without that modification:

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

With this latest addition, 0xD9 is the only remaining whole in 0xD0 to
0xDB series so hopefully we are about done with these Bamboo
additions.

Chris

> @@ -1551,6 +1554,7 @@ const struct usb_device_id wacom_ids[] =3D {
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xD2) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xD3) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xD4) },
> + =A0 =A0 =A0 { USB_DEVICE_WACOM(0xD5) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xD6) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xD7) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xD8) },
> --
> 1.7.5.2
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
