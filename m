From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 3/4] Fix hover in Android (Gingerbread)
Date: Fri, 8 Jul 2011 09:13:18 +0800
Message-ID: <CADqH6Vyn3=WW3bz5YESTEJgTUfaeCgX7rQjT6s96DfjQnENa_w@mail.gmail.com>
References: <1310072700-2829-1-git-send-email-killertofu@gmail.com>
	<1310072700-2829-3-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37549 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab1GHBNT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2011 21:13:19 -0400
Received: by bwd5 with SMTP id 5so1373607bwd.19
        for <linux-input@vger.kernel.org>; Thu, 07 Jul 2011 18:13:18 -0700 (PDT)
In-Reply-To: <1310072700-2829-3-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jgerecke@wacom.com>, Dima Zavin <dima@android.com>

On Fri, Jul 8, 2011 at 5:04 AM, Jason Gerecke <killertofu@gmail.com> wr=
ote:
> As of Gingerbread, Android does not pay attention to if the pen
> is in contact with the screen, or merely in proximity. Since the
> Xorg Wacom driver does not make use of MT pen events, we simply
> do not emit MT data while hovering.

Hi Jason,

It would be nice if you could CC me next time. I would like to be
aware of the changes to the driver I wrote and use.

I guess the change below is ok, but it changes existing behavior. It
doesn't affect my apps (be aware that Xorg and Android may be the well
known users, but there are other custom apps).

Thanks,
jaya

>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---
> =A0Now being sent upstream to LKML at the behest of Google.
>
> =A0drivers/input/touchscreen/wacom_w8001.c | =A0 10 ++++++----
> =A01 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/=
touchscreen/wacom_w8001.c
> index e94a21a..40ed685 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -279,10 +279,12 @@ static void report_pen_events(struct w8001 *w80=
01, struct w8001_coord *coord)
> =A0 =A0 =A0 =A0input_report_key(dev, BTN_STYLUS, coord->f1);
> =A0 =A0 =A0 =A0input_report_key(dev, w8001->type, coord->rdy);
>
> - =A0 =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_X, coord->x);
> - =A0 =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_Y, coord->y);
> - =A0 =A0 =A0 input_report_abs(dev, ABS_MT_PRESSURE, coord->pen_press=
ure);
> - =A0 =A0 =A0 input_report_abs(dev, ABS_MT_TOOL_TYPE, MT_TOOL_PEN);
> + =A0 =A0 =A0 if (coord->pen_pressure > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_X=
, coord->x);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_Y=
, coord->y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(dev, ABS_MT_PRESSURE, =
coord->pen_pressure);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(dev, ABS_MT_TOOL_TYPE,=
 MT_TOOL_PEN);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0input_mt_sync(dev);
> =A0 =A0 =A0 =A0input_sync(dev);
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
