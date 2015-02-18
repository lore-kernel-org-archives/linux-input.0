From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH] HID: hid-sony: Prevent LED overrun
Date: Tue, 17 Feb 2015 23:57:07 -0500
Message-ID: <54E41BA3.7060107@gmail.com>
References: <1424229290-32089-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:61209 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbbBRE5P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2015 23:57:15 -0500
Received: by mail-ig0-f182.google.com with SMTP id h15so34549516igd.3
        for <linux-input@vger.kernel.org>; Tue, 17 Feb 2015 20:57:14 -0800 (PST)
In-Reply-To: <1424229290-32089-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Simon Wood <simon@mungewell.org>, Jiri Kosina <jkosina@suse.cz>

> If the value written to led1 is larger than 1 (for SixAxis or Intec
> controllers),
> it can effect other leds on the device.
> For example:
> # echo 3 > /sys/class/leds/0003\:054C\:0268.0013\:\:sony1/brightness
>
> turns on both led1 and led2, led2 does not then behave as expected through it's
> own interface.
>
> Patch limits the LEDs 'value' to the 'max brightness', thus preventing bug.
>
> Tested with SixAxis DS3, DS4 and Intec (3rd party) controllers, via USB
> connection.
>
> Signed-off-by: Simon Wood <si...@mungewell.org>
> ---
>   drivers/hid/hid-sony.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 31e9d25..385fa1f 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1296,6 +1296,9 @@ static void sony_led_set_brightness(struct led_classdev
> *led,
>                          drv_data->led_delay_on[n] ||
>                          drv_data->led_delay_off[n]))) {
>   
> +                       if (value > led->max_brightness)
> +                               value = led->max_brightness;
> +
>                          drv_data->led_state[n] = value;
>   
>                          /* Setting the brightness stops the blinking */
> -- 
> 1.9.1

Hi Simon,

I think this was a bug in the LED system itself fixed by this commit:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/leds/leds.h?id=56d06fdee534124f79b51ff92232373b783cddc2

In kernel 3.19 the brightness values are clamped correctly and I can't 
replicate your bug.

Regards,
Frank
