From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2 3/5] HID: sony: Perform a boundry check on the sixaxis
 battery level index.
Date: Mon, 24 Feb 2014 11:23:22 +0100
Message-ID: <CANq1E4ThS2x_=Gw-wc24WYXz128kFXc_0-sH3_5OCuWmaMmo3w@mail.gmail.com>
References: <1392914164-31899-1-git-send-email-frank.praznik@oh.rr.com>
	<1392914164-31899-4-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:44845 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbaBXKXX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Feb 2014 05:23:23 -0500
Received: by mail-ie0-f182.google.com with SMTP id tp5so3311242ieb.27
        for <linux-input@vger.kernel.org>; Mon, 24 Feb 2014 02:23:22 -0800 (PST)
In-Reply-To: <1392914164-31899-4-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Thu, Feb 20, 2014 at 5:36 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> Make sure that an out-of-bounds read doesn't occur in the Sixaxis battery level
> lookup table in the event that the controller sends an invalid battery status
> value in the report.
>
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
>  drivers/hid/hid-sony.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index a51a9c0..b39e3ab 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -854,7 +854,8 @@ static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
>                 battery_capacity = 100;
>                 battery_charging = !(rd[30] & 0x01);
>         } else {
> -               battery_capacity = sixaxis_battery_capacity[rd[30]];
> +               __u8 index = rd[30] <= 5 ? rd[30] : 5;
> +               battery_capacity = sixaxis_battery_capacity[index];

Does it make sense to read something else on invalid reports? Sounds
weird to me to just read at a lower index in case it's too short.
Shouldn't you just bail out? But the worst that can happen is wrong
battery values reported to user-space, so I'm fine with it.

Thanks
David

>                 battery_charging = 0;
>         }
>         cable_state = !((rd[31] >> 4) & 0x01);
> --
> 1.8.5.3
>
