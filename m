From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] HID: wacom: Fix poor prox handling in 'wacom_pl_irq'
Date: Thu, 26 Jan 2017 12:44:48 -0800
Message-ID: <CAF8JNh+7qdZdLknr59qEBQDFKB9-kxTQ=vj7YsoRkdeLcgmNYg@mail.gmail.com>
References: <20170126170622.6760-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36786 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753139AbdAZUpT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 26 Jan 2017 15:45:19 -0500
Received: by mail-ot0-f195.google.com with SMTP id 36so28717831otx.3
        for <linux-input@vger.kernel.org>; Thu, 26 Jan 2017 12:45:19 -0800 (PST)
In-Reply-To: <20170126170622.6760-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Thu, Jan 26, 2017 at 9:06 AM, Jason Gerecke <killertofu@gmail.com> wrote:
> Commit 025bcc1 performed cleanup work on the 'wacom_pl_irq' function, making
> it follow the standards used in the rest of the codebase. The change
> unintiontionally allowed the function to send input events from reports
> that are not marked as being in prox. This can cause problems as the
> report values for X, Y, etc. are not guaranteed to be correct. In
> particular, occasionally the tablet will send a report with these values
> set to zero. If such a report is received it can caus an unexpected jump
> in the XY position.
>
> This patch surrounds more of the processing code with a proximity check,
> preventing these zeroed reports from overwriting the current state. To
> be safe, only the tool type and ABS_MISC events should be reported when
> the pen is marked as being out of prox.
>
> Fixes: 025bcc1540 ("HID: wacom: Simplify 'wacom_pl_irq'")
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Reviewed-by: Ping Cheng <pingc@wacom.com>

Cheers,
Ping

P.S., this patch has been tested by users at linuxwacom.sf.net

> ---
>  drivers/hid/wacom_wac.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 0884dc9554fd..672145b0d8f5 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -166,19 +166,21 @@ static int wacom_pl_irq(struct wacom_wac *wacom)
>                 wacom->id[0] = STYLUS_DEVICE_ID;
>         }
>
> -       pressure = (signed char)((data[7] << 1) | ((data[4] >> 2) & 1));
> -       if (features->pressure_max > 255)
> -               pressure = (pressure << 1) | ((data[4] >> 6) & 1);
> -       pressure += (features->pressure_max + 1) / 2;
> -
> -       input_report_abs(input, ABS_X, data[3] | (data[2] << 7) | ((data[1] & 0x03) << 14));
> -       input_report_abs(input, ABS_Y, data[6] | (data[5] << 7) | ((data[4] & 0x03) << 14));
> -       input_report_abs(input, ABS_PRESSURE, pressure);
> -
> -       input_report_key(input, BTN_TOUCH, data[4] & 0x08);
> -       input_report_key(input, BTN_STYLUS, data[4] & 0x10);
> -       /* Only allow the stylus2 button to be reported for the pen tool. */
> -       input_report_key(input, BTN_STYLUS2, (wacom->tool[0] == BTN_TOOL_PEN) && (data[4] & 0x20));
> +       if (prox) {
> +               pressure = (signed char)((data[7] << 1) | ((data[4] >> 2) & 1));
> +               if (features->pressure_max > 255)
> +                       pressure = (pressure << 1) | ((data[4] >> 6) & 1);
> +               pressure += (features->pressure_max + 1) / 2;
> +
> +               input_report_abs(input, ABS_X, data[3] | (data[2] << 7) | ((data[1] & 0x03) << 14));
> +               input_report_abs(input, ABS_Y, data[6] | (data[5] << 7) | ((data[4] & 0x03) << 14));
> +               input_report_abs(input, ABS_PRESSURE, pressure);
> +
> +               input_report_key(input, BTN_TOUCH, data[4] & 0x08);
> +               input_report_key(input, BTN_STYLUS, data[4] & 0x10);
> +               /* Only allow the stylus2 button to be reported for the pen tool. */
> +               input_report_key(input, BTN_STYLUS2, (wacom->tool[0] == BTN_TOOL_PEN) && (data[4] & 0x20));
> +       }
>
>         if (!prox)
>                 wacom->id[0] = 0;
> --
> 2.11.0
>
