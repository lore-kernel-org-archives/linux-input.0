From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 3/4] input: wacom - use switch statement for wacom_tpc_irq()
Date: Sun, 18 Dec 2011 19:23:08 -0600
Message-ID: <CAGzDe_Y39ympA0f3HhzhW0Z4c+SgptioeD3JSuBwQQNvfxLJEw@mail.gmail.com>
References: <1324082282-32762-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54226 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053Ab1LSBXK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Dec 2011 20:23:10 -0500
Received: by eaaj10 with SMTP id j10so4349278eaa.19
        for <linux-input@vger.kernel.org>; Sun, 18 Dec 2011 17:23:09 -0800 (PST)
In-Reply-To: <1324082282-32762-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

On Fri, Dec 16, 2011 at 6:38 PM, Ping Cheng <pinglinux@gmail.com> wrote=
:
> And add two new data formats.
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0 24 ++++++++++++++++++------
> =A0drivers/input/tablet/wacom_wac.h | =A0 =A02 ++
> =A02 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 33a4359..8dc185d 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -833,12 +833,24 @@ static int wacom_tpc_irq(struct wacom_wac *waco=
m, size_t len)
> =A0 =A0 =A0 =A0dbg("wacom_tpc_irq: received report #%d with %d contac=
ts",
> =A0 =A0 =A0 =A0 =A0 =A0 data[0], wacom->features.touch_max);
>
> - =A0 =A0 =A0 if (len =3D=3D WACOM_PKGLEN_TPC1FG || data[0] =3D=3D WA=
COM_REPORT_TPC1FG)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_tpc_single_touch(wacom, le=
n);
> - =A0 =A0 =A0 else if (data[0] =3D=3D WACOM_REPORT_TPC2FG)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_tpc_mt_touch(wacom);
> - =A0 =A0 =A0 else if (data[0] =3D=3D WACOM_REPORT_PENABLED)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_tpc_pen(wacom);
> + =A0 =A0 =A0 switch (len) {
> + =A0 =A0 =A0 case WACOM_PKGLEN_TPC1FG:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return wacom_tpc_single_touch(wacom,=
 len);
> +
> + =A0 =A0 =A0 case WACOM_PKGLEN_TPC2FG:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_tpc_mt_touch(wacom);
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (data[0]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case WACOM_REPORT_TPC1FG:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case WACOM_REPORT_TPCHID:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case WACOM_REPORT_TPCST:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_tpc_single=
_touch(wacom, len);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case WACOM_REPORT_PENABLED:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_tpc_pen(wa=
com);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/=
wacom_wac.h
> index 6ddd2e4..1c9dc3e 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -39,6 +39,8 @@
> =A0#define WACOM_REPORT_INTUOSPAD =A0 =A0 =A0 =A0 12
> =A0#define WACOM_REPORT_TPC1FG =A0 =A0 =A0 =A0 =A0 =A06
> =A0#define WACOM_REPORT_TPC2FG =A0 =A0 =A0 =A0 =A0 =A013
> +#define WACOM_REPORT_TPCHID =A0 =A0 =A0 =A0 =A0 =A015
> +#define WACOM_REPORT_TPCST =A0 =A0 =A0 =A0 =A0 =A0 16
>
> =A0/* device quirks */
> =A0#define WACOM_QUIRK_MULTI_INPUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
001
> --
> 1.7.6.4
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
