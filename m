From: Jeffrey Brown <jeffbrown@android.com>
Subject: Re: [PATCH 4/4] Only report multi-touch when pen is out of range
Date: Fri, 8 Jul 2011 23:19:30 -0700
Message-ID: <CAMu+ixj+mcm8usLpGJcXmzBbS3Xqp0BKAhTvxDWa69sB0YNMOg@mail.gmail.com>
References: <1310072700-2829-1-git-send-email-killertofu@gmail.com> <1310072700-2829-4-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60394 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab1GIGUL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 Jul 2011 02:20:11 -0400
Received: by bwd5 with SMTP id 5so2195195bwd.19
        for <linux-input@vger.kernel.org>; Fri, 08 Jul 2011 23:20:10 -0700 (PDT)
In-Reply-To: <1310072700-2829-4-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jgerecke@wacom.com>, Dima Zavin <dima@android.com>

I don't see why we should filter out multitouch while the pen is in
range.  There are many reasons why it might be useful to support
simultaneous pen and touch.

=46or example, use one finger to select a color to draw with and use th=
e
pen in the other hand to draw.

Jeff.

On Thu, Jul 7, 2011 at 2:05 PM, Jason Gerecke <killertofu@gmail.com> wr=
ote:
> Don't bother evaluating multi-touch packets from the hardware
> when the pen is in range. Single-touch is already filtered, but
> not MT.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---
> =A0Now being sent upstream to LKML at the behest of Google.
>
> =A0drivers/input/touchscreen/wacom_w8001.c | =A0 =A05 ++++-
> =A01 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/=
touchscreen/wacom_w8001.c
> index 40ed685..393fd3c 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -379,7 +379,10 @@ static irqreturn_t w8001_interrupt(struct serio =
*serio,
> =A0 =A0 =A0 =A0/* 2 finger touch packet */
> =A0 =A0 =A0 =A0case W8001_PKTLEN_TOUCH2FG - 1:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0w8001->idx =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 parse_multi_touch(w8001);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (w8001->type !=3D BTN_TOOL_PEN &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 w8001->type !=3D BTN_TOOL_RUBBE=
R) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parse_multi_touch(w8001=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
> --
> 1.7.5.2
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
