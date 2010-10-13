From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 4/5] input: wacom: Add support for the Bamboo Touch
 trackpad (rev4)
Date: Wed, 13 Oct 2010 09:31:09 -0700
Message-ID: <AANLkTikpAfeSgCsaBWPcW7EncbW7UtLVjH=bpmmbVU-7@mail.gmail.com>
References: <1283607783-29388-1-git-send-email-rydberg@euromail.se>
	<1283607783-29388-5-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56337 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab0JMQbK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 12:31:10 -0400
Received: by wyb28 with SMTP id 28so1225842wyb.19
        for <linux-input@vger.kernel.org>; Wed, 13 Oct 2010 09:31:09 -0700 (PDT)
In-Reply-To: <1283607783-29388-5-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org

Hi Henrik,

I know this patchset is under Linus tree and I've acked it already.
But, I am trying to catch up with the fast moving MT train and to make
sure the train is moving to my destination :).

More comments in line.

Ping

On Sat, Sep 4, 2010 at 6:43 AM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> Add support for the Bamboo Touch trackpad, and make it work with
> both the Synaptics X Driver and the Multitouch X Driver. The device
> uses MT slots internally, so the choice of protocol is a given.
>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0 88 ++++++++++++++++++++++++=
++++++++++++++
> =A0drivers/input/tablet/wacom_wac.h | =A0 =A03 +
> =A02 files changed, 91 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index ca18b4d..97295aa 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -855,6 +855,54 @@ static int wacom_tpc_irq(struct wacom_wac *wacom=
, size_t len)
> =A0 =A0 =A0 =A0return retval;
> =A0}
>
> +static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
> +{
> + =A0 =A0 =A0 static int trkid;
> + =A0 =A0 =A0 struct input_dev *input =3D wacom->input;
> + =A0 =A0 =A0 unsigned char *data =3D wacom->data;
> + =A0 =A0 =A0 int sp =3D 0, sx =3D 0, sy =3D 0, count =3D 0;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 if (len !=3D WACOM_PKGLEN_BBTOUCH)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < 2; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int p =3D data[9 * i + 2];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_slot(input, i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int x =3D get_unaligned=
_be16(&data[9 * i + 3]) & 0x7ff;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int y =3D get_unaligned=
_be16(&data[9 * i + 5]) & 0x7ff;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input,=
 ABS_MT_PRESSURE, p);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input,=
 ABS_MT_POSITION_X, x);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input,=
 ABS_MT_POSITION_Y, y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wacom->id[i] < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->=
id[i] =3D trkid++ & MAX_TRACKING_ID;

Why do we need an arbitrary MAX_TRACKING_ID when the device can tell
us how many IDs we can have and it tracks the individual fingers for
us? In this case, there are only two ID/fingers and the ID can be
retrieved from the raw data. I must be missing something in the
defintion of MAX_TRACKING_ID.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!count++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sp =3D =
p, sx =3D x, sy =3D y;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[i] =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_MT_TRACKING=
_ID, wacom->id[i]);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 input_report_key(input, BTN_TOUCH, count > 0);
> + =A0 =A0 =A0 input_report_key(input, BTN_TOOL_FINGER, count =3D=3D 1=
);
> + =A0 =A0 =A0 input_report_key(input, BTN_TOOL_DOUBLETAP, count =3D=3D=
 2);
> +
> + =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, sp);
> + =A0 =A0 =A0 input_report_abs(input, ABS_X, sx);
> + =A0 =A0 =A0 input_report_abs(input, ABS_Y, sy);
> +
> + =A0 =A0 =A0 input_report_key(input, BTN_LEFT, (data[1] & 0x08) !=3D=
 0);
> + =A0 =A0 =A0 input_report_key(input, BTN_FORWARD, (data[1] & 0x04) !=
=3D 0);
> + =A0 =A0 =A0 input_report_key(input, BTN_BACK, (data[1] & 0x02) !=3D=
 0);
> + =A0 =A0 =A0 input_report_key(input, BTN_RIGHT, (data[1] & 0x01) !=3D=
 0);

This implementation impairs the value of those buttons since I know a
lot of users want them configurable. If we can not or do not pass a
generic set to the userland, we will need to make it configurable in
the kernel driver as Dmitry suggested (if I remember it correctly).
Which approach, in the userland or the kernel, do you like, Henrik?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
