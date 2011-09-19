From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/3] Input: wacom - add ABS_DISTANCE to Bamboo Pen reports
Date: Mon, 19 Sep 2011 12:11:54 -0700
Message-ID: <CAF8JNh+95MhpmQY-HNxgBLknOhN5do9NxDZ48rZ-YrjF7vQ9Rg@mail.gmail.com>
References: <1316050588-13473-1-git-send-email-chris@cnpbagwell.com>
	<1316050588-13473-3-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42915 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756451Ab1ISTLz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Sep 2011 15:11:55 -0400
Received: by gxk6 with SMTP id 6so3703781gxk.19
        for <linux-input@vger.kernel.org>; Mon, 19 Sep 2011 12:11:54 -0700 (PDT)
In-Reply-To: <1316050588-13473-3-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, chris@cnpbagwell.com

On Wed, Sep 14, 2011 at 6:36 PM,  <chris@cnpbagwell.com> wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
>
> Tablet reports a distance of 0 right at highest point possible
> to be in proximity and distance_max when touching tablet. Inverse
> the distance since user land has no way of knowing ABS_DISTANCE
> is not distance from tablet.
>
> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>

In case Dmitry is waiting for my confirmation for this patch (all
patches in this series are either acked or reviewed):

Acked-by: Ping Cheng <pingc@wacom.com>

Thanks.

Ping

> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0 34 ++++++++++++++++++++++--=
----------
> =A01 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 1503425..d7da1b0 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -874,7 +874,14 @@ static int wacom_bpt_pen(struct wacom_wac *wacom=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0x =3D le16_to_cpup((__le16 *)&data[2])=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0y =3D le16_to_cpup((__le16 *)&data[4])=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p =3D le16_to_cpup((__le16 *)&data[6])=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 d =3D data[8];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* convert distance from out prox to di=
stance from tablet.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* distance will be greater than dist=
ance_max once
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* touching and applying pressure. do=
 not report negative
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* distance.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data[8] <=3D wacom->features.distan=
ce_max)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d =3D wacom->features.d=
istance_max - data[8];
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pen =3D data[1] & 0x01;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0btn1 =3D data[1] & 0x02;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0btn2 =3D data[1] & 0x04;
> @@ -1224,6 +1231,9 @@ void wacom_setup_input_capabilities(struct inpu=
t_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_TOOL_PEN=
, input_dev->keybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_STYLUS, =
input_dev->keybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_STYLUS2,=
 input_dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(in=
put_dev, ABS_DISTANCE, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 features->distance_max,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 0, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> @@ -1444,37 +1454,37 @@ static const struct wacom_features wacom_feat=
ures_0x47 =3D
> =A0 =A0 =A0 =A0 =A031, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0xD0 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo 2FG", =A0 =A0 WACOM_PKGLEN_BBFUN, =A0 =
=A0 14720, =A09200, 1023,
> - =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> + =A0 =A0 =A0 =A0 31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xD1 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo 2FG 4x5", WACOM_PKGLEN_BBFUN, =A0 =A0 =
14720, =A09200, 1023,
> - =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> + =A0 =A0 =A0 =A0 31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xD2 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo Craft", =A0 WACOM_PKGLEN_BBFUN, =A0 =A0=
 14720, =A09200, 1023,
> - =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> + =A0 =A0 =A0 =A0 31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xD3 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN, =A0 =A0 =
21648, 13530, 1023,
> - =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> + =A0 =A0 =A0 =A0 31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xD4 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo Pen", =A0 =A0 WACOM_PKGLEN_BBFUN, =A0 =
=A0 14720, =A09200, 1023,
> - =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> + =A0 =A0 =A0 =A0 31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xD5 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo Pen 6x8", =A0 =A0 WACOM_PKGLEN_BBFUN, =
21648, 13530, 1023,
> - =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> + =A0 =A0 =A0 =A0 31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xD6 =3D
> =A0 =A0 =A0 =A0{ "Wacom BambooPT 2FG 4x5", WACOM_PKGLEN_BBFUN, =A0 14=
720, =A09200, 1023,
> - =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> + =A0 =A0 =A0 =A0 31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xD7 =3D
> =A0 =A0 =A0 =A0{ "Wacom BambooPT 2FG Small", WACOM_PKGLEN_BBFUN, 1472=
0, =A09200, 1023,
> - =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> + =A0 =A0 =A0 =A0 31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xD8 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo Comic 2FG", WACOM_PKGLEN_BBFUN, =A0 21=
648, 13530, 1023,
> - =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> + =A0 =A0 =A0 =A0 31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xDA =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo 2FG 4x5 SE", WACOM_PKGLEN_BBFUN, =A014=
720, =A09200, 1023,
> - =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> + =A0 =A0 =A0 =A0 31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static struct wacom_features wacom_features_0xDB =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo 2FG 6x8 SE", WACOM_PKGLEN_BBFUN, =A021=
648, 13530, 1023,
> - =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> + =A0 =A0 =A0 =A0 31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0x6004 =3D
> =A0 =A0 =A0 =A0{ "ISD-V4", =A0 =A0 =A0 =A0 =A0 =A0 =A0 WACOM_PKGLEN_G=
RAPHIRE, =A012800, =A08000, =A0255,
> =A0 =A0 =A0 =A0 =A00, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> --
> 1.7.6
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
