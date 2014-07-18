From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 1/2] input: wacom: Support up to 2048 pressure levels with ISDv4
Date: Fri, 18 Jul 2014 16:12:21 -0700
Message-ID: <CANRwn3TSsZMvGU1Oj1iu2a24JKxXfa2fsk8236fj7ek7TgEWeg@mail.gmail.com>
References: <1404164806-5141-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:57293 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756528AbaGRXMX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jul 2014 19:12:23 -0400
Received: by mail-la0-f51.google.com with SMTP id el20so3326330lab.10
        for <linux-input@vger.kernel.org>; Fri, 18 Jul 2014 16:12:22 -0700 (PDT)
In-Reply-To: <1404164806-5141-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jason Gerecke <killertofu@gmail.com>

On Mon, Jun 30, 2014 at 2:46 PM, Jason Gerecke <killertofu@gmail.com> w=
rote:
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---
>  drivers/input/tablet/wacom_wac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 977d05c..61a45a5 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1093,7 +1093,7 @@ static int wacom_tpc_pen(struct wacom_wac *waco=
m)
>                 input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
>                 input_report_abs(input, ABS_X, le16_to_cpup((__le16 *=
)&data[2]));
>                 input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *=
)&data[4]));
> -               input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x0=
3) << 8) | data[6]);
> +               input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x0=
7) << 8) | data[6]);
>                 input_report_key(input, BTN_TOUCH, data[1] & 0x05);
>                 input_report_key(input, wacom->tool[0], prox);
>                 return 1;
> --
> 2.0.0
>

Just making sure these two patches don't get lost in all the work
Benjamin's doing. They're going to conflict, so depending on the
timeline for merging his patches, we can either push these up now(ish)
or I'll rebase afterwards.

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
