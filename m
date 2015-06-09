From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH 1/3] Input: export LEDs as class devices in sysfs
Date: Tue, 9 Jun 2015 15:19:55 +0200
Message-ID: <20150609131955.GA3045@type>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sonata.ens-lyon.org ([140.77.166.138]:49875 "EHLO
	sonata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbbFINVe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 09:21:34 -0400
Content-Disposition: inline
In-Reply-To: <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hello,

Dmitry Torokhov, le Mon 08 Jun 2015 14:43:08 -0700, a =E9crit :
> 1. Instead of making LED class devices part of the input device they =
are
> implemented as an input handler (and thus are completely separate fro=
m
> input core).

That's nicer indeed.  Not defining triggers per LED however does not
permit to e.g. switch two leds of a keyboard independently of what
produces input events.  I'm personally fine with it, I just wanted to
mention it since this example of usage was cited at some point in the
thread.

> +	[LED_NUML]	=3D { "num-lock", VT_TRIGGER("kbd-numlock") },
> +	[LED_CAPSL]	=3D { "caps-lock", VT_TRIGGER("kbd-capslock") },
> +	[LED_SCROLLL]	=3D { "scroll-lock", VT_TRIGGER("kbd-scrollock") },

I'd tend to think we'd want to harmonize the user-visible LED names and
kbd trigger names, i.e. use "numlock", "capslock" and "scrollock" in
both case (or something else, but the same for LED and trigger). In my
patch I simply used the corresponding LED or kbd macro names, but there
is probably no strong reason to this, while there is probably a good
reason to choose coherent and nice user-visible names.

> +static enum led_brightness input_leds_brightness_get(struct led_clas=
sdev *cdev)
> +{
> +	struct input_led *led =3D container_of(cdev, struct input_led, cdev=
);
> +	struct input_dev *input =3D led->handle->dev;
> +
> +	return test_bit(led->code, input->ledbit) ? LED_FULL : LED_OFF;

This always returns LED_FULL, whatever the current state of the LED, is
that really what we want?  Userspace will be surprised to read 255 from
sysfs whatever it writes to it (with actual proper effect on the LED).
Simply not defining input_leds_brightness_get and letting the LED core
manage the value does get a proper "brightness" sysfs file behavior, is
there a reason not to do that?

> +	int led_no =3D 0;

=2E..

> +	for_each_set_bit(led_code, dev->ledbit, LED_CNT) {
> +		struct input_led *led =3D &leds->leds[led_no];

When reading this I wondered what value led_no was, perhaps the
initialization to 0 should be moved to right before the for_each_set_bi=
t
loop, to make the code clearer.

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
