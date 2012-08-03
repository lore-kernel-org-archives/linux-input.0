From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 1/2] HID: wacom: Use half of brightness for low state
Date: Fri, 3 Aug 2012 10:42:40 -0700
Message-ID: <CAF8JNh+55Z4ZmBA=2yF7HBz464ZYs68NSU5OEYSkqP-s_bvEYg@mail.gmail.com>
References: <1343755676-2999-1-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:33577 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751290Ab2HCRmm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Aug 2012 13:42:42 -0400
Received: by lahd3 with SMTP id d3so517420lah.19
        for <linux-input@vger.kernel.org>; Fri, 03 Aug 2012 10:42:40 -0700 (PDT)
In-Reply-To: <1343755676-2999-1-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org

On Tue, Jul 31, 2012 at 10:27 AM, Przemo Firszt <przemo@firszt.eu> wrote:
> Intuos4 WL leds have 2 states: high and low. With no activity tablet
> uses low state; using pen triggers high state. Both can be set
> independently, but it would require setting another led device to
> control them separately. This patch uses the brightness set through leds
> subsytem as high and half of that value as low.
>
> Signed-off-by: Przemo Firszt <przemo@firszt.eu>

Acked-by: Ping Cheng <pingc@wacom.com> for the whole set.

Thank you, Przemo, for your effort.

Ping

> ---
>  drivers/hid/hid-wacom.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index fe23a1e..848842e 100644
> --- a/drivers/hid/hid-wacom.c
> +++ b/drivers/hid/hid-wacom.c
> @@ -91,7 +91,8 @@ static void wacom_leds_set_brightness(struct led_classdev *led_dev,
>         if (buf) {
>                 buf[0] = WAC_CMD_LED_CONTROL;
>                 buf[1] = led;
> -               buf[2] = value;
> +               buf[2] = value >> 2;
> +               buf[3] = value;
>                 hdev->hid_output_raw_report(hdev, buf, 9, HID_FEATURE_REPORT);
>                 kfree(buf);
>         }
> --
> 1.7.10.2
>
