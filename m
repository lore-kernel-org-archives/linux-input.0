From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 2/2] input - wacom : add two new devices (0xed and 0xef)
Date: Thu, 17 May 2012 11:21:58 -0500
Message-ID: <CAGzDe_bW-K=p=h4LOE=+TGuChJH=9ZYO_6P=z3D_7m+XH_oo2Q@mail.gmail.com>
References: <1336785920-2397-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42186 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657Ab2EQQWA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 May 2012 12:22:00 -0400
Received: by lbbgm6 with SMTP id gm6so1428070lbb.19
        for <linux-input@vger.kernel.org>; Thu, 17 May 2012 09:21:58 -0700 (PDT)
In-Reply-To: <1336785920-2397-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Fri, May 11, 2012 at 8:25 PM, Ping Cheng <pinglinux@gmail.com> wrote=
:
> 0xed supports pen and one finger touch; 0xef is pen only.
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0 13 ++++++++++++-
> =A0drivers/input/tablet/wacom_wac.h | =A0 =A02 ++
> =A02 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index c40dcb7..fd0cf4d3 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -888,7 +888,7 @@ static int wacom_tpc_single_touch(struct wacom_wa=
c *wacom, size_t len)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prox =3D data[0] & 0x0=
1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0x =3D get_unaligned_le=
16(&data[1]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0y =3D get_unaligned_le=
16(&data[3]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else { /* with capacity */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prox =3D data[1] & 0x0=
1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0x =3D le16_to_cpup((__=
le16 *)&data[2]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0y =3D le16_to_cpup((__=
le16 *)&data[4]);
> @@ -961,6 +961,7 @@ static int wacom_tpc_irq(struct wacom_wac *wacom,=
 size_t len)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case WACOM_REPORT_TPC1FG:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case WACOM_REPORT_TPCHID:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case WACOM_REPORT_TPCST:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case WACOM_REPORT_TPC1FGE:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return wacom_tpc_singl=
e_touch(wacom, len);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case WACOM_REPORT_TPCMT:
> @@ -1244,6 +1245,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac,=
 size_t len)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0 =A0 =A0case TABLETPC:
> + =A0 =A0 =A0 case TABLETPCE:
> =A0 =A0 =A0 =A0case TABLETPC2FG:
> =A0 =A0 =A0 =A0case MTSCREEN:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sync =3D wacom_tpc_irq(wacom_wac, len)=
;
> @@ -1569,6 +1571,7 @@ int wacom_setup_input_capabilities(struct input=
_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fall through */
>
> =A0 =A0 =A0 =A0case TABLETPC:
> + =A0 =A0 =A0 case TABLETPCE:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__clear_bit(ABS_MISC, input_dev->absbi=
t);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(INPUT_PROP_DIRECT, input_dev=
->propbit);
> @@ -1886,6 +1889,12 @@ static const struct wacom_features wacom_featu=
res_0xE6 =3D
> =A0static const struct wacom_features wacom_features_0xEC =3D
> =A0 =A0 =A0 =A0{ "Wacom ISDv4 EC", =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE,=
 =A025710, 14500, =A0255,
> =A0 =A0 =A0 =A0 =A00, TABLETPC, =A0 =A0WACOM_INTUOS_RES, WACOM_INTUOS=
_RES };
> +static const struct wacom_features wacom_features_0xED =3D
> + =A0 =A0 =A0 { "Wacom ISDv4 ED", =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE, =
=A026202, 16325, =A0255,
> + =A0 =A0 =A0 =A0 0, TABLETPCE, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> +static const struct wacom_features wacom_features_0xEF =3D
> + =A0 =A0 =A0 { "Wacom ISDv4 EF", =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE, =
=A026202, 16325, =A0255,
> + =A0 =A0 =A0 =A0 0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };

I can't find reason why you've created a TABLETPCE.  I was looking for
some sort of logic that hit's "if (type <=3D TABLETPC" that your trying
to avoid on 0xED but I couldn't find it.

Is the type needed?

Chris

> =A0static const struct wacom_features wacom_features_0x47 =3D
> =A0 =A0 =A0 =A0{ "Wacom Intuos2 6x8", =A0 =A0WACOM_PKGLEN_INTUOS, =A0=
 =A020320, 16240, 1023,
> =A0 =A0 =A0 =A0 =A031, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> @@ -2060,6 +2069,8 @@ const struct usb_device_id wacom_ids[] =3D {
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xE5) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xE6) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xEC) },
> + =A0 =A0 =A0 { USB_DEVICE_WACOM(0xED) },
> + =A0 =A0 =A0 { USB_DEVICE_WACOM(0xEF) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0x47) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xF4) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_LENOVO(0x6004) },
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/=
wacom_wac.h
> index 8708043..bd5d37b 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -48,6 +48,7 @@
> =A0#define WACOM_REPORT_TPCMT =A0 =A0 =A0 =A0 =A0 =A0 13
> =A0#define WACOM_REPORT_TPCHID =A0 =A0 =A0 =A0 =A0 =A015
> =A0#define WACOM_REPORT_TPCST =A0 =A0 =A0 =A0 =A0 =A0 16
> +#define WACOM_REPORT_TPC1FGE =A0 =A0 =A0 =A0 =A0 18
>
> =A0/* device quirks */
> =A0#define WACOM_QUIRK_MULTI_INPUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
001
> @@ -80,6 +81,7 @@ enum {
> =A0 =A0 =A0 =A0WIRELESS,
> =A0 =A0 =A0 =A0BAMBOO_PT,
> =A0 =A0 =A0 =A0TABLETPC, =A0 /* add new TPC below */
> + =A0 =A0 =A0 TABLETPCE,
> =A0 =A0 =A0 =A0TABLETPC2FG,
> =A0 =A0 =A0 =A0MTSCREEN,
> =A0 =A0 =A0 =A0MAX_TYPE
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
