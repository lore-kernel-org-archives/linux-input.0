From: Ping Cheng <pingc@wacom.com>
Subject: RE: [PATCH 2/3 v2] input : wacom - Update Graphire4 and old Bamboo
 tablet buttons
Date: Wed, 6 Jul 2011 05:38:36 +0000
Message-ID: <C6AE45FA1D5BD74994491BCF5D47EED909E029@Exchange1.wacom.com>
References: <1309908332-18829-1-git-send-email-pinglinux@gmail.com>
 <CAGzDe_YBseby=y4_Rp5Gd_0qPOpg3kWFdPrkVeZ=8sZ_dD1hrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:49877 "HELO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753114Ab1GFFjt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jul 2011 01:39:49 -0400
In-Reply-To: <CAGzDe_YBseby=y4_Rp5Gd_0qPOpg3kWFdPrkVeZ=8sZ_dD1hrQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>, Ping Cheng <pinglinux@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "rydberg@euromail.se" <rydberg@euromail.se>

Chris,

Thank you for the review. BTN_LEFT/RIGHT is declared in the code inside=
 the " case GRAPHIRE:" block if you take a look at the whole routine.

Ping

-----Original Message-----
=46rom: Chris Bagwell [mailto:chris@cnpbagwell.com]=20
Sent: Tuesday, July 05, 2011 7:32 PM
To: Ping Cheng
Cc: linux-input@vger.kernel.org; dmitry.torokhov@gmail.com; rydberg@eur=
omail.se; Ping Cheng
Subject: Re: [PATCH 2/3 v2] input : wacom - Update Graphire4 and old Ba=
mboo tablet buttons

On Tue, Jul 5, 2011 at 6:25 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> Bamboo touch sets BTN_BACK, BTN_FORWARD, BTN_LEFT, and BTN_RIGHT as=20
> the default button events for tablet buttons. Change Graphire4 and ol=
d=20
> Bamboo to the same settings.

This should make the tablets more useful out of the box.

At least with xf86-input-wacom, I believe today's default mapping cause=
s an almost direct mapping to X button #'s so that means BTN_0 is dropp=
ed (X buttons start at 1), BTN_1 treated as LEFT and BTN_4/5 treated as=
 BACK/FORWARD (it skips over buttons 4/5/6/7 when creating default mapp=
ings).

So for most people, its only the BTN_LEFT/RIGHT that would cause a visi=
ble difference and I'd think for the better.

I have one question below.

>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0 19 ++++++++-----------
> =A01 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c=20
> b/drivers/input/tablet/wacom_wac.c
> index b93501a..19554a4 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -275,8 +275,8 @@ static int wacom_graphire_irq(struct wacom_wac=20
> *wacom)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prox =3D data[7] & 0xf8;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (prox || wacom->id[1]) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom->id[1] =3D PAD_D=
EVICE_ID;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_0, (data[7] &=20
> 0x40));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_4, (data[7] &=20
> 0x80));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_BACK, (data[7] &=20
> + 0x40));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_FORWARD, (data[7]=20
> + & 0x80));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rw =3D ((data[7] & 0x1=
8) >> 3) - ((data[7] &=20
> 0x20) >> 3);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_rel(input=
, REL_WHEEL, rw);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!prox)
> @@ -291,10 +291,10 @@ static int wacom_graphire_irq(struct wacom_wac=20
> *wacom)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prox =3D (data[7] & 0xf8) || data[8];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (prox || wacom->id[1]) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom->id[1] =3D PAD_D=
EVICE_ID;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_0, (data[7] &=20
> 0x08));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_1, (data[7] &=20
> 0x20));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_4, (data[7] &=20
> 0x10));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_5, (data[7] &=20
> 0x40));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_BACK, (data[7] &=20
> + 0x08));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_LEFT, (data[7] &=20
> + 0x20));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_FORWARD, (data[7]=20
> + & 0x10));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_RIGHT, (data[7] &=20
> + 0x40));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input=
, ABS_WHEEL, (data[8] &=20
> 0x7f));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!prox)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom-=
>id[1] =3D 0; @@ -1076,17 +1076,14=20
> @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
>
> =A0 =A0 =A0 =A0switch (wacom_wac->features.type) {
> =A0 =A0 =A0 =A0case WACOM_MO:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_1, input_dev->keybit);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_5, input_dev->keybit);
> -

Can you add a message to commit on why this is deleted instead of chang=
ed?  I'm guessing WACOM_MO series must support mice pucks and so alread=
y declare BTN_LEFT and BTN_RIGHT?

Other than that:

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(input_dev, ABS_WH=
EEL, 0, 71, 0,=20
> 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fall through */
>
> =A0 =A0 =A0 =A0case WACOM_G4:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_capability(input_dev, EV_MSC=
, MSC_SERIAL);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_0, input_dev->keybit);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_4, input_dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_BACK, input_dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_FORWARD, input_dev->keybi=
t);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fall through */
>
> =A0 =A0 =A0 =A0case GRAPHIRE:
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
