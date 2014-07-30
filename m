From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
Subject: Re: Trouble with an HP stylus
Date: Wed, 30 Jul 2014 23:50:15 +0200
Message-ID: <20140730215015.GA20917@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nef2.ens.fr ([129.199.96.40]:2576 "EHLO nef2.ens.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbaG3WR0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jul 2014 18:17:26 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: benjamin.tissoires@gmail.com
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, eric.brunet@lps.ens.fr

Hi!

Thanks for both answers.

To recall the context:

>PRODUCT=3D3/3eb/840b/111
>NAME=3D"Atmel Atmel maXTouch Digitizer Pen"
>
>Playing with evtest, it appears that the kernel reports the X coordina=
te
>in ABS_X and in ABS_Y, while the Y coordinate goes into ABS_Z and ABS_=
RX;
=20
> I have already seen this Atmel panel, and the problem was that they u=
sed
> twice X then twice Y to report coordinates:
>=20
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 2619f7f..b70d4c3 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -603,7 +603,7 @@ static void hidinput_configure_usage(struct hid_i=
nput
> *hidinput, struct hid_fiel if (field->flags & HID_MAIN_ITEM_RELATIVE)
> map_rel(usage->hid & 0xf);
>                         else
> -                               map_abs(usage->hid & 0xf);
> +                               map_abs_clear(usage->hid & 0xf);
>                         break;
>=20
>                 case HID_GD_HATSWITCH:=20

Yep, this patch helps. It helps a lot. the ABS_X and ABS_Y coordinates =
are now=20
correct, the ABS_Z and ABS_RX coordinates are gone, I can point and cli=
ck with=20
the pen.

However, things do not work totally as expected, and the pen remains un=
usable=20
for many drawing applications. I am not sure if the problem lies in the=
=20
input/hid system, or in Xorg's evdev driver or in the applications, but=
 the=20
problem I am about to describe occurs only with the pen: everything wor=
ks as=20
expected with the touchpad (recognized as a simple mouse) or with the f=
inger on=20
the touchscreen:
  * when I try to make annotations with okular with the "draw a freehan=
d line"=20
tool, the line I draw with the pen jumps (drawing a straight line) to s=
ome=20
apparently random point outside okular's window and jumps back (drawing=
=20
another straight line) to where the pen is, several times per second. I=
 don't=20
want to send a jpg to the whole mailing list, but I can send a snapshot=
 on a=20
private email on request.
  * when I try to use a drawing tool with gimp or mypaint, each time I =
raise
the pen and put it at some other place to make another drawing, a strai=
ght line=20
is drawn between the last and the new position of the pen.

Here is what happens on evtest if I touch the screen with the pen, move=
 a
bit and stops touching; I didn't see anything suspicious, except maybe =
that=20
sometimes there is a single ABS_X or a single ABS_Y without the other=20
coordinate between two SYN_REPORT.

Event: time 1406710046.690615, type 1 (EV_KEY), code 320 (BTN_TOOL_PEN)=
, value 1
Event: time 1406710046.690615, type 3 (EV_ABS), code 0 (ABS_X), value 3=
279
Event: time 1406710046.690615, type 3 (EV_ABS), code 1 (ABS_Y), value 2=
555
Event: time 1406710046.690615, -------------- SYN_REPORT ------------
Event: time 1406710046.697616, type 4 (EV_MSC), code 4 (MSC_SCAN), valu=
e d0042
Event: time 1406710046.697616, type 1 (EV_KEY), code 330 (BTN_TOUCH), v=
alue 1
Event: time 1406710046.697616, -------------- SYN_REPORT ------------
Event: time 1406710046.713550, type 3 (EV_ABS), code 0 (ABS_X), value 3=
287
Event: time 1406710046.713550, type 3 (EV_ABS), code 1 (ABS_Y), value 2=
539
[ Many other EV_ABS events]
Event: time 1406710047.317556, type 3 (EV_ABS), code 0 (ABS_X), value 3=
755
Event: time 1406710047.317556, type 3 (EV_ABS), code 1 (ABS_Y), value 1=
699
Event: time 1406710047.317556, -------------- SYN_REPORT ------------
Event: time 1406710047.340556, type 4 (EV_MSC), code 4 (MSC_SCAN), valu=
e d0042
Event: time 1406710047.340556, type 1 (EV_KEY), code 330 (BTN_TOUCH), v=
alue 0
Event: time 1406710047.340556, -------------- SYN_REPORT ------------
Event: time 1406710047.342504, type 1 (EV_KEY), code 320 (BTN_TOOL_PEN)=
, value 0
Event: time 1406710047.342504, -------------- SYN_REPORT ------------

Thanks again for the patch,

        =C9ric Brunet
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
