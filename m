From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] Input: wacom - add product id used by Samsung Slate 7
Date: Wed, 7 Dec 2011 06:56:47 -0800
Message-ID: <CAF8JNhJznE_N0vCpHV+SasW8VJ-zGoO8B9HXgMHwZR3BWZZjNw@mail.gmail.com>
References: <1323228457-18735-1-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51208 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756255Ab1LGO4s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2011 09:56:48 -0500
Received: by ghbz2 with SMTP id z2so559851ghb.19
        for <linux-input@vger.kernel.org>; Wed, 07 Dec 2011 06:56:47 -0800 (PST)
In-Reply-To: <1323228457-18735-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, stable@kernel.org, mail@harveybraun.com

On Tue, Dec 6, 2011 at 7:27 PM,  <chris@cnpbagwell.com> wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
>
> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>

Acked-by: Ping Cheng <pinglinux@gmail.com>

Thank you, Chris.

Ping

> ---
>
> New product ID reported by Harvey Braun on linuxwacom mailing list
> and also tested this patch with new hardware. Link to report plus
> results:
>
> http://sourceforge.net/mailarchive/forum.php?thread_name=3DCAGzDe_bTo=
DXsztnDsyPiVAmEKXd60aG2zA2%2BTCf3M_X6Z%2BLtTg%40mail.gmail.com&forum_na=
me=3Dlinuxwacom-discuss
>
> =A0drivers/input/tablet/wacom_wac.c | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index da0d876..2ee47d0 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1470,6 +1470,9 @@ static const struct wacom_features wacom_featur=
es_0xE3 =3D
> =A0static const struct wacom_features wacom_features_0xE6 =3D
> =A0 =A0 =A0 =A0{ "Wacom ISDv4 E6", =A0 =A0 =A0 WACOM_PKGLEN_TPC2FG, =A0=
 =A027760, 15694, =A0255,
> =A0 =A0 =A0 =A0 =A00, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES=
 };
> +static const struct wacom_features wacom_features_0xEC =3D
> + =A0 =A0 =A0 { "Wacom ISDv4 EC", =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE, =
=A025710, 14500, =A0255,
> + =A0 =A0 =A0 =A0 0, TABLETPC, =A0 =A0WACOM_INTUOS_RES, WACOM_INTUOS_=
RES };
> =A0static const struct wacom_features wacom_features_0x47 =3D
> =A0 =A0 =A0 =A0{ "Wacom Intuos2 6x8", =A0 =A0WACOM_PKGLEN_INTUOS, =A0=
 =A020320, 16240, 1023,
> =A0 =A0 =A0 =A0 =A031, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> @@ -1611,6 +1614,7 @@ const struct usb_device_id wacom_ids[] =3D {
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xE2) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xE3) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xE6) },
> + =A0 =A0 =A0 { USB_DEVICE_WACOM(0xEC) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0x47) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_LENOVO(0x6004) },
> =A0 =A0 =A0 =A0{ }
> --
> 1.7.7.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
