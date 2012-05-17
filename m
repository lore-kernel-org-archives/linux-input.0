From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 1/2] input - wacom : rearrange type enum
Date: Thu, 17 May 2012 13:03:53 -0500
Message-ID: <CAGzDe_Y3hMjX9cn8J4btPDUEWt0PMn=UeDhZOEEOTEEoV1o+Yg@mail.gmail.com>
References: <1336785898-2359-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52225 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761935Ab2EQSDz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 May 2012 14:03:55 -0400
Received: by lbbgm6 with SMTP id gm6so1499016lbb.19
        for <linux-input@vger.kernel.org>; Thu, 17 May 2012 11:03:54 -0700 (PDT)
In-Reply-To: <1336785898-2359-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

=46or both patches:

Acked-by: Chris Bagwell <chris@cnpbagwell.com>

On Fri, May 11, 2012 at 8:24 PM, Ping Cheng <pinglinux@gmail.com> wrote=
:
> So we can simplify a few type related if statements
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> =A0drivers/input/tablet/wacom_sys.c | =A0 10 +++-------
> =A0drivers/input/tablet/wacom_wac.c | =A0 =A06 ++----
> =A0drivers/input/tablet/wacom_wac.h | =A0 =A06 +++---
> =A03 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index b3a8bd3..79b5cfb 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -440,8 +440,7 @@ static int wacom_query_tablet_data(struct usb_int=
erface *intf, struct wacom_feat
> =A0 =A0 =A0 =A0/* ask to report Wacom data */
> =A0 =A0 =A0 =A0if (features->device_type =3D=3D BTN_TOOL_FINGER) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* if it is an MT Tablet PC touch */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D TABLETPC2FG |=
|
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->type =3D=3D MTSCREEN)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type > TABLETPC) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep_da=
ta[0] =3D 3;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep_da=
ta[1] =3D 4;
> @@ -460,7 +459,7 @@ static int wacom_query_tablet_data(struct usb_int=
erface *intf, struct wacom_feat
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} while ((error < 0 ||=
 rep_data[1] !=3D 4) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 limit=
++ < WAC_MSG_RETRIES);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 } else if (features->type !=3D TABLETPC &&
> + =A0 =A0 =A0 } else if (features->type <=3D BAMBOO_PT &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->type !=3D WIRELESS &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D=3D BTN_=
TOOL_PEN) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
> @@ -510,10 +509,7 @@ static int wacom_retrieve_hid_descriptor(struct =
usb_interface *intf,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* only devices that support touch need to retrieve th=
e info */
> - =A0 =A0 =A0 if (features->type !=3D TABLETPC &&
> - =A0 =A0 =A0 =A0 =A0 features->type !=3D TABLETPC2FG &&
> - =A0 =A0 =A0 =A0 =A0 features->type !=3D BAMBOO_PT &&
> - =A0 =A0 =A0 =A0 =A0 features->type !=3D MTSCREEN) {
> + =A0 =A0 =A0 if (features->type < BAMBOO_PT) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 004bc1b..c40dcb7 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1317,10 +1317,8 @@ void wacom_setup_device_quirks(struct wacom_fe=
atures *features)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* these device have multiple inputs */
> - =A0 =A0 =A0 if (features->type =3D=3D TABLETPC || features->type =3D=
=3D TABLETPC2FG ||
> - =A0 =A0 =A0 =A0 =A0 features->type =3D=3D BAMBOO_PT || features->ty=
pe =3D=3D WIRELESS ||
> - =A0 =A0 =A0 =A0 =A0 (features->type >=3D INTUOS5S && features->type=
 <=3D INTUOS5L) ||
> - =A0 =A0 =A0 =A0 =A0 features->type =3D=3D MTSCREEN)
> + =A0 =A0 =A0 if (features->type >=3D WIRELESS ||
> + =A0 =A0 =A0 =A0 =A0 (features->type >=3D INTUOS5S && features->type=
 <=3D INTUOS5L))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->quirks |=3D WACOM_QUIRK_MULT=
I_INPUT;
>
> =A0 =A0 =A0 =A0/* quirk for bamboo touch with 2 low res touches */
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/=
wacom_wac.h
> index 78fbd3f..8708043 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -62,8 +62,6 @@ enum {
> =A0 =A0 =A0 =A0PTU,
> =A0 =A0 =A0 =A0PL,
> =A0 =A0 =A0 =A0DTU,
> - =A0 =A0 =A0 BAMBOO_PT,
> - =A0 =A0 =A0 WIRELESS,
> =A0 =A0 =A0 =A0INTUOS,
> =A0 =A0 =A0 =A0INTUOS3S,
> =A0 =A0 =A0 =A0INTUOS3,
> @@ -79,7 +77,9 @@ enum {
> =A0 =A0 =A0 =A0CINTIQ,
> =A0 =A0 =A0 =A0WACOM_BEE,
> =A0 =A0 =A0 =A0WACOM_MO,
> - =A0 =A0 =A0 TABLETPC,
> + =A0 =A0 =A0 WIRELESS,
> + =A0 =A0 =A0 BAMBOO_PT,
> + =A0 =A0 =A0 TABLETPC, =A0 /* add new TPC below */
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
