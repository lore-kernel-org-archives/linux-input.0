From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 1/2] input - wacom : rearrange type enum
Date: Wed, 23 May 2012 09:04:57 -0700
Message-ID: <CANRwn3QrHDJMe7QDNYZavNqgDuCh3eZS4thVL=eCX5H_EAU0VQ@mail.gmail.com>
References: <1336785898-2359-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:52843 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932497Ab2EWQE7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 May 2012 12:04:59 -0400
Received: by weyu7 with SMTP id u7so4732881wey.19
        for <linux-input@vger.kernel.org>; Wed, 23 May 2012 09:04:57 -0700 (PDT)
In-Reply-To: <1336785898-2359-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Fri, May 11, 2012 at 6:24 PM, Ping Cheng <pinglinux@gmail.com> wrote=
:
> So we can simplify a few type related if statements
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> =C2=A0drivers/input/tablet/wacom_sys.c | =C2=A0 10 +++-------
> =C2=A0drivers/input/tablet/wacom_wac.c | =C2=A0 =C2=A06 ++----
> =C2=A0drivers/input/tablet/wacom_wac.h | =C2=A0 =C2=A06 +++---
> =C2=A03 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index b3a8bd3..79b5cfb 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -440,8 +440,7 @@ static int wacom_query_tablet_data(struct usb_int=
erface *intf, struct wacom_feat
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* ask to report Wacom data */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (features->device_type =3D=3D BTN_TOOL_=
=46INGER) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* if it is an=
 MT Tablet PC touch */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (features->type=
 =3D=3D TABLETPC2FG ||
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 feat=
ures->type =3D=3D MTSCREEN) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (features->type=
 > TABLETPC) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0do {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rep_data[0] =3D 3;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rep_data[1] =3D 4;
> @@ -460,7 +459,7 @@ static int wacom_query_tablet_data(struct usb_int=
erface *intf, struct wacom_feat
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0} while ((error < 0 || rep_data[1] !=3D 4) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 limit++ < WAC_MSG_RETRIES);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 } else if (features->type !=3D TABLETPC &&
> + =C2=A0 =C2=A0 =C2=A0 } else if (features->type <=3D BAMBOO_PT &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 featur=
es->type !=3D WIRELESS &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 featur=
es->device_type =3D=3D BTN_TOOL_PEN) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do {
> @@ -510,10 +509,7 @@ static int wacom_retrieve_hid_descriptor(struct =
usb_interface *intf,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* only devices that support touch need to=
 retrieve the info */
> - =C2=A0 =C2=A0 =C2=A0 if (features->type !=3D TABLETPC &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 features->type !=3D TABLETPC2FG =
&&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 features->type !=3D BAMBOO_PT &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 features->type !=3D MTSCREEN) {
> + =C2=A0 =C2=A0 =C2=A0 if (features->type < BAMBOO_PT) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 004bc1b..c40dcb7 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1317,10 +1317,8 @@ void wacom_setup_device_quirks(struct wacom_fe=
atures *features)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* these device have multiple inputs */
> - =C2=A0 =C2=A0 =C2=A0 if (features->type =3D=3D TABLETPC || features=
->type =3D=3D TABLETPC2FG ||
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 features->type =3D=3D BAMBOO_PT =
|| features->type =3D=3D WIRELESS ||
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (features->type >=3D INTUOS5S &&=
 features->type <=3D INTUOS5L) ||
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 features->type =3D=3D MTSCREEN)
> + =C2=A0 =C2=A0 =C2=A0 if (features->type >=3D WIRELESS ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (features->type >=3D INTUOS5S &&=
 features->type <=3D INTUOS5L))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0features->quir=
ks |=3D WACOM_QUIRK_MULTI_INPUT;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* quirk for bamboo touch with 2 low res t=
ouches */
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/=
wacom_wac.h
> index 78fbd3f..8708043 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -62,8 +62,6 @@ enum {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0PTU,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0PL,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DTU,
> - =C2=A0 =C2=A0 =C2=A0 BAMBOO_PT,
> - =C2=A0 =C2=A0 =C2=A0 WIRELESS,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0INTUOS,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0INTUOS3S,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0INTUOS3,
> @@ -79,7 +77,9 @@ enum {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CINTIQ,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0WACOM_BEE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0WACOM_MO,
> - =C2=A0 =C2=A0 =C2=A0 TABLETPC,
> + =C2=A0 =C2=A0 =C2=A0 WIRELESS,
> + =C2=A0 =C2=A0 =C2=A0 BAMBOO_PT,
> + =C2=A0 =C2=A0 =C2=A0 TABLETPC, =C2=A0 /* add new TPC below */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0TABLETPC2FG,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0MTSCREEN,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0MAX_TYPE
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml

In case this is waiting for a review to come in, for both patches in th=
e set:

Reviewed-by: Jason Gerecke <killertofu@gmail.com>

Jason

---
Day xee-nee-svsh duu-'ushtlh-ts'it;
nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
Huu-chan xuu naa~-gha.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
