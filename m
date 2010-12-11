From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] Add support for Wacom Bamboo Pen (CTL460, Product ID 0xD4).
Date: Fri, 10 Dec 2010 18:36:12 -0800
Message-ID: <AANLkTikwK5UmQHYkcv86jEh69tuKriKcACitAgs=odQ4@mail.gmail.com>
References: <alpine.DEB.1.10.1012101914290.2131@fakemat>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40057 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab0LKCgO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Dec 2010 21:36:14 -0500
Received: by wwa36 with SMTP id 36so4420674wwa.1
        for <linux-input@vger.kernel.org>; Fri, 10 Dec 2010 18:36:13 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.1012101914290.2131@fakemat>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "kevin.granade@gmail.com" <azmodean@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, chris@cnpbagwell.com, pingc@wacom.com

On Fri, Dec 10, 2010 at 6:10 PM, kevin.granade@gmail.com
<azmodean@gmail.com> wrote:
> Add the features struct and device table entry to enable the Wacom Ba=
mboo
> Pen.
>
> Generated against input/for-linus since that seems to be the most rec=
ent
> input branch.
>
> Signed-off-by: Kevin Granade <kevin.granade@gmail.com>

Acked-by: Ping Cheng <pingc@wacom.com>

Ping

> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 4852b44..435b0af 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1436,6 +1436,8 @@ static struct wacom_features wacom_features_0xD=
2 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo Craft", =A0 WACOM_PKGLEN_BBFUN, =A0 =A0=
 14720, =A09200, 1023, 63, BAMBOO_PT };
> =A0static struct wacom_features wacom_features_0xD3 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN, =A0 =A0 =
21648, 13530, 1023, 63, BAMBOO_PT };
> +static const struct wacom_features wacom_features_0xD4 =3D
> + =A0 =A0 =A0 { "Wacom Bamboo Pen", =A0 =A0 WACOM_PKGLEN_BBFUN, =A0 =A0=
 14720, =A09200, =A0255, 63, BAMBOO_PT };
> =A0static struct wacom_features wacom_features_0xD8 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo Comic 2FG", WACOM_PKGLEN_BBFUN, =A0 21=
648, 13530, 1023, 63, BAMBOO_PT };
> =A0static struct wacom_features wacom_features_0xDA =3D
> @@ -1510,6 +1512,7 @@ const struct usb_device_id wacom_ids[] =3D {
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xD1) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xD2) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xD3) },
> + =A0 =A0 =A0 { USB_DEVICE_WACOM(0xD4) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xD8) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xDA) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xDB) },
> --
> 1.5.6.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
