From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 1/2] Constify wacom_features for a new missed Bamboo models
Date: Sun, 27 Mar 2011 09:14:33 -0500
Message-ID: <AANLkTikV4YJEukLXgwUBnxP5G058hHhvftNENKqb8-CO@mail.gmail.com>
References: <1301099345-5464-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41717 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab1C0OOf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Mar 2011 10:14:35 -0400
Received: by bwz15 with SMTP id 15so1868613bwz.19
        for <linux-input@vger.kernel.org>; Sun, 27 Mar 2011 07:14:33 -0700 (PDT)
In-Reply-To: <1301099345-5464-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

On Fri, Mar 25, 2011 at 7:29 PM, Ping Cheng <pinglinux@gmail.com> wrote=
:
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0 16 ++++++++--------
> =A01 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 5597637..ba6e17c 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1366,23 +1366,23 @@ static const struct wacom_features wacom_feat=
ures_0xE3 =3D
> =A0 =A0 =A0 =A0{ "Wacom ISDv4 E3", =A0 =A0 =A0 WACOM_PKGLEN_TPC2FG, =A0=
 =A026202, 16325, =A0255, =A00, TABLETPC2FG };
> =A0static const struct wacom_features wacom_features_0x47 =3D
> =A0 =A0 =A0 =A0{ "Wacom Intuos2 6x8", =A0 =A0WACOM_PKGLEN_INTUOS, =A0=
 =A020320, 16240, 1023, 31, INTUOS };
> -static struct wacom_features wacom_features_0xD0 =3D
> +static const struct wacom_features wacom_features_0xD0 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo 2FG", =A0 =A0 WACOM_PKGLEN_BBFUN, =A0 =
=A0 14720, =A09200, 1023, 63, BAMBOO_PT };
> -static struct wacom_features wacom_features_0xD1 =3D
> +static const struct wacom_features wacom_features_0xD1 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo 2FG 4x5", WACOM_PKGLEN_BBFUN, =A0 =A0 =
14720, =A09200, 1023, 63, BAMBOO_PT };
> -static struct wacom_features wacom_features_0xD2 =3D
> +static const struct wacom_features wacom_features_0xD2 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo Craft", =A0 WACOM_PKGLEN_BBFUN, =A0 =A0=
 14720, =A09200, 1023, 63, BAMBOO_PT };
> -static struct wacom_features wacom_features_0xD3 =3D
> +static const struct wacom_features wacom_features_0xD3 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN, =A0 =A0 =
21648, 13530, 1023, 63, BAMBOO_PT };
> =A0static const struct wacom_features wacom_features_0xD4 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo Pen", =A0 =A0 WACOM_PKGLEN_BBFUN, =A0 =
=A0 14720, =A09200, =A0255, 63, BAMBOO_PT };
> -static struct wacom_features wacom_features_0xD6 =3D
> +static const struct wacom_features wacom_features_0xD6 =3D
> =A0 =A0 =A0 =A0{ "Wacom BambooPT 2FG 4x5", WACOM_PKGLEN_BBFUN, =A0 14=
720, =A09200, 1023, 63, BAMBOO_PT };
> -static struct wacom_features wacom_features_0xD7 =3D
> +static const struct wacom_features wacom_features_0xD7 =3D
> =A0 =A0 =A0 =A0{ "Wacom BambooPT 2FG Small", WACOM_PKGLEN_BBFUN, 1472=
0, =A09200, 1023, 63, BAMBOO_PT };
> -static struct wacom_features wacom_features_0xD8 =3D
> +static const struct wacom_features wacom_features_0xD8 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo Comic 2FG", WACOM_PKGLEN_BBFUN, =A0 21=
648, 13530, 1023, 63, BAMBOO_PT };
> -static struct wacom_features wacom_features_0xDA =3D
> +static const struct wacom_features wacom_features_0xDA =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo 2FG 4x5 SE", WACOM_PKGLEN_BBFUN, =A014=
720, =A09200, 1023, 63, BAMBOO_PT };
> =A0static struct wacom_features wacom_features_0xDB =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo 2FG 6x8 SE", WACOM_PKGLEN_BBFUN, =A021=
648, 13530, 1023, 63, BAMBOO_PT };
> --
> 1.7.4
>
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
