From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 2/3 v2] input : wacom - Update Graphire4 and old Bamboo
 tablet buttons
Date: Tue, 5 Jul 2011 21:32:08 -0500
Message-ID: <CAGzDe_YBseby=y4_Rp5Gd_0qPOpg3kWFdPrkVeZ=8sZ_dD1hrQ@mail.gmail.com>
References: <1309908332-18829-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64540 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120Ab1GFCcJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 22:32:09 -0400
Received: by iwn6 with SMTP id 6so5713861iwn.19
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 19:32:08 -0700 (PDT)
In-Reply-To: <1309908332-18829-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, rydberg@euromail.se, Ping Cheng <pingc@wacom.com>

On Tue, Jul 5, 2011 at 6:25 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> Bamboo touch sets BTN_BACK, BTN_FORWARD, BTN_LEFT, and BTN_RIGHT
> as the default button events for tablet buttons. Change Graphire4
> and old Bamboo to the same settings.

This should make the tablets more useful out of the box.

At least with xf86-input-wacom, I believe today's default mapping
causes an almost direct mapping to X button #'s so that means BTN_0 is
dropped (X buttons start at 1), BTN_1 treated as LEFT and BTN_4/5
treated as BACK/FORWARD (it skips over buttons 4/5/6/7 when creating
default mappings).

So for most people, its only the BTN_LEFT/RIGHT that would cause a
visible difference and I'd think for the better.

I have one question below.

>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0 19 ++++++++-----------
> =A01 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index b93501a..19554a4 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -275,8 +275,8 @@ static int wacom_graphire_irq(struct wacom_wac *w=
acom)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prox =3D data[7] & 0xf8;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (prox || wacom->id[1]) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom->id[1] =3D PAD_D=
EVICE_ID;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_0, (data[7] & 0x40));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_4, (data[7] & 0x80));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_BACK, (data[7] & 0x40));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_FORWARD, (data[7] & 0x80));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rw =3D ((data[7] & 0x1=
8) >> 3) - ((data[7] & 0x20) >> 3);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_rel(input=
, REL_WHEEL, rw);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!prox)
> @@ -291,10 +291,10 @@ static int wacom_graphire_irq(struct wacom_wac =
*wacom)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prox =3D (data[7] & 0xf8) || data[8];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (prox || wacom->id[1]) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom->id[1] =3D PAD_D=
EVICE_ID;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_0, (data[7] & 0x08));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_1, (data[7] & 0x20));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_4, (data[7] & 0x10));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_5, (data[7] & 0x40));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_BACK, (data[7] & 0x08));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_LEFT, (data[7] & 0x20));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_FORWARD, (data[7] & 0x10));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_RIGHT, (data[7] & 0x40));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input=
, ABS_WHEEL, (data[8] & 0x7f));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!prox)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom-=
>id[1] =3D 0;
> @@ -1076,17 +1076,14 @@ void wacom_setup_input_capabilities(struct in=
put_dev *input_dev,
>
> =A0 =A0 =A0 =A0switch (wacom_wac->features.type) {
> =A0 =A0 =A0 =A0case WACOM_MO:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_1, input_dev->keybit);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_5, input_dev->keybit);
> -

Can you add a message to commit on why this is deleted instead of
changed?  I'm guessing WACOM_MO series must support mice pucks and so
already declare BTN_LEFT and BTN_RIGHT?

Other than that:

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(input_dev, ABS_WH=
EEL, 0, 71, 0, 0);
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
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
