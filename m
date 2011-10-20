From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/6] Input: wacom - remove unused bamboo HID parsing
Date: Thu, 20 Oct 2011 14:17:51 -0700
Message-ID: <CAF8JNhJyJP4sffrqO=_jt5C56T6WsC843pOF7AyWww14k1vLKw@mail.gmail.com>
References: <1318814981-30607-1-git-send-email-chris@cnpbagwell.com>
	<1318814981-30607-3-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41485 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834Ab1JTVRw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Oct 2011 17:17:52 -0400
Received: by ywf7 with SMTP id 7so3251507ywf.19
        for <linux-input@vger.kernel.org>; Thu, 20 Oct 2011 14:17:51 -0700 (PDT)
In-Reply-To: <1318814981-30607-3-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Sun, Oct 16, 2011 at 6:29 PM, =A0<chris@cnpbagwell.com> wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
>
> Bamboo's do not declared a Digitizer-Stylus so the if() was
> never executed. =A0wacom_features already contains correct stylus
> packet length.

Since this change affects all Bamboo series, I assume you have tested
it with your old Bamboo pen and touch. If so,

> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>

Acked-by: Ping Cheng <pingc@wacom.com> for the whole set.

Ping

> ---
> =A0drivers/input/tablet/wacom_sys.c | =A0 =A04 ----
> =A01 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index 4f35473..620f0c3 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -245,8 +245,6 @@ static int wacom_parse_hid(struct usb_interface *=
intf, struct hid_descriptor *hi
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0/* penabled only accepts exact bytes of data */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0if (features->type =3D=3D TABLETPC2FG)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen =3D WACOM_PKGL=
EN_GRAPHIRE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D BAMBOO_PT)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKG=
LEN_BBFUN;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0features->device_type =3D BTN_TOOL_PEN;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0features->x_max =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_le16(&report[i + =
3]);
> @@ -295,8 +293,6 @@ static int wacom_parse_hid(struct usb_interface *=
intf, struct hid_descriptor *hi
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0/* penabled only accepts exact bytes of data */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0if (features->type =3D=3D TABLETPC2FG)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen =3D WACOM_PKGL=
EN_GRAPHIRE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D BAMBOO_PT)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKG=
LEN_BBFUN;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0features->device_type =3D BTN_TOOL_PEN;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_le16(&report[i + =
3]);
> --
> 1.7.6.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
