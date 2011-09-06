From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] Input: wacom - fix touch on newer Bamboo's
Date: Tue, 6 Sep 2011 09:46:03 -0700
Message-ID: <CAF8JNhJc_ZPeZ-UnqZMFocUMY+BBPsuokJhPAhxE0q29u5ycgA@mail.gmail.com>
References: <1315190661-7133-1-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63798 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab1IFQqF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2011 12:46:05 -0400
Received: by gxk21 with SMTP id 21so4110603gxk.19
        for <linux-input@vger.kernel.org>; Tue, 06 Sep 2011 09:46:04 -0700 (PDT)
In-Reply-To: <1315190661-7133-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

On Sun, Sep 4, 2011 at 7:44 PM,  <chris@cnpbagwell.com> wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
>
> Bamboo's with Product ID's > 0xD4 return values unrelated to pressure
> in touch 1 pressure field. =A0They also report touch 2's X/Y values
> shifted down 1 byte (where pressure was). =A0This results in jumpy
> 1 finger touch and totally invalid 2nd finger data.
>
> For touch detection, switch to a Touch Present single bit that
> all versions of Bamboo support.
>
> For touch 2 offset, calculate offset based on a bit that is set
> different between the two packet layouts.
>
> Since touch pressure reports were removed from driver, there was
> no need to be reading pressure any more.
>
> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0 15 +++++++++------
> =A01 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 2d88316..651f109 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -800,20 +800,23 @@ static int wacom_bpt_touch(struct wacom_wac *wa=
com)
> =A0 =A0 =A0 =A0int i;
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < 2; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int p =3D data[9 * i + 2];
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool touch =3D p && !wacom->shared->sty=
lus_in_proximity;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int offset =3D (data[1] & 0x80) ? (8 * =
i) : (9 * i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool touch =3D data[offset + 3] & 0x80;

Can we add:  touch =3D touch  && !wacom->shared->stylus_in_proximity;

here so we can keep the old flow? I remember Henrik recommended this
approach over the if-statement for my patch. Except that,

Reviewed-by: Ping Cheng <pinglinux@gmail.com>

Ping

> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_slot(input, i);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_report_slot_state(input, MT_TO=
OL_FINGER, touch);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Touch events need to be disabled wh=
ile stylus is
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * in proximity because user's hand is=
 resting on touchpad
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * and sending unwanted events. =A0Use=
r expects tablet buttons
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * to continue working though.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wacom->shared->stylus_in_proximity)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 touch =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_slot(input, i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_report_slot_state(input, MT_TO=
OL_FINGER, touch);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (touch) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int x =3D get_unaligned=
_be16(&data[9 * i + 3]) & 0x7ff;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int y =3D get_unaligned=
_be16(&data[9 * i + 5]) & 0x7ff;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int x =3D get_unaligned=
_be16(&data[offset + 3]) & 0x7ff;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int y =3D get_unaligned=
_be16(&data[offset + 5]) & 0x7ff;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->quirks &=
 WACOM_QUIRK_BBTOUCH_LOWRES) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0x <<=3D=
 5;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0y <<=3D=
 5;
> --
> 1.7.6
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
