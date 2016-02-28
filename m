From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: [PATCH 3/3] input: gpio_keys: Make use of the device property API
Date: Sun, 28 Feb 2016 02:03:34 +0000
Message-ID: <CA+V1Lzrag5QPAPjjhqp8R6uUG4NPb9sG7axiJoBGk4q=ozXV0w@mail.gmail.com>
References: <1455876982-6743-1-git-send-email-geert+renesas@glider.be>
	<1455876982-6743-4-git-send-email-geert+renesas@glider.be>
	<20160222195815.GB28343@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f67.google.com ([209.85.192.67]:35128 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992640AbcB1CDf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Feb 2016 21:03:35 -0500
In-Reply-To: <20160222195815.GB28343@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vincent Pelletier <plr.vincent@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org

Sorry to interrupt with question, but I guess this thread has right
people for related to this topic question.
The question is reversed to the topic - how to, having working touch
driver in Android and Windows determine which exactly gpio pin is used
as INT\WAKE gpio by the driver?
Or for example even when I have some variant of such gpio pin how to
ensure that it is exactly this gpio?
For example practical task: I am trying to determine which exactly
gpio pin is responsible for INT/WAKE touchscreen on Chuwi Vi10
(baytrail x86_64 Arch 4.4.2 vanilla kernel with my custom config).
Exploring /sys/class/gpio/* have guessed that in Android it is
probably gpio134 but in Linux 4.4.2 probably gpio393. How to compare
such pins and ensure that in Linux 393 gpio is the same as 134 in
Android?
Is this possible to do in any predictable (not guessing or enumerating
all range) way?

Regards and thanks for replies,
                                                 Serge Kolotylo.

On Mon, Feb 22, 2016 at 7:58 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, Feb 19, 2016 at 11:16:22AM +0100, Geert Uytterhoeven wrote:
>> @@ -887,7 +870,7 @@ static struct platform_driver gpio_keys_device_driver = {
>>       .driver         = {
>>               .name   = "gpio-keys",
>>               .pm     = &gpio_keys_pm_ops,
>> -             .of_match_table = of_match_ptr(gpio_keys_of_match),
>> +             .of_match_table = gpio_keys_of_match,
>
> Why are we changing this? I think match table should still be guarded
> by #ifdef CONFIG_OF.
>
> Thanks.
>
> --
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
