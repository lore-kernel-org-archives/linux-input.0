From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 02/15] GPIO: port LoCoMo gpio support from old driver
Date: Tue, 11 Nov 2014 17:16:38 +0400
Message-ID: <CALT56yPr42FV66USngocw=eWPt81d5R2MJxmzBnv02HOMmXAkA@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
	<1414454528-24240-3-git-send-email-dbaryshkov@gmail.com>
	<CACRpkdY7tRadod2vQfEytmw-ubaMAvr_=XTczD5bUMkqie0xkg@mail.gmail.com>
	<CALT56yOgMUA7o2dzfHph=S2zkDV4zERzMh4ishpPwpAx7Cqj6Q@mail.gmail.com>
	<CACRpkdb7v3LmOhbhQ9TPk1_bnLnpwizawW6RQvhQRLSjRewAaQ@mail.gmail.com>
	<CALT56yO9f8wzaArnmfQSDzCM3S+2oT+62anH5kbFY3WdEt_HZg@mail.gmail.com>
	<20141106060335.GR8509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:47629 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbaKKNQj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2014 08:16:39 -0500
In-Reply-To: <20141106060335.GR8509@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>

2014-11-06 9:03 GMT+03:00 Mark Brown <broonie@kernel.org>:
> On Thu, Nov 06, 2014 at 01:33:24AM +0400, Dmitry Eremin-Solenikov wrote:
>> 2014-11-03 16:43 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
>
>> > Yes that's the point: if you use regmap mmio you get the RMW-locking
>> > for free, with the regmap implementation.
>
>> Just to be more concrete. Currently locomo_gpio_ack_irq() function uses
>> one lock and one unlock for doing 3 consecutive RMW I I convert locomo
>> to regmap, will that be 3 lock/unlock calls or still one? (Or maybe I'm
>> trying to be over-protective here and adding more lock/unlock cycles
>> won't matter that much?)
>
> You'll get three lock/unlocks, we could add an interface for bulk
> updates under one lock if it's important though.
>
>> Next question: if I have to export regmap to several subdrivers, is it better
>> to have one big regmap or to have one-map-per-driver approach?
>
> One regmap for the physical register map which is shared between all the
> users.

Mark, Linus,

Just to better understand your suggestions: do you want me to convert
to regmap only gpio driver or do you suggest to convert all LoCoMo drivers?
That is doable, of course, but the amount of changes is overwhelming.
Also I'm concerned about the performance impact from going through
regmap layers.


-- 
With best wishes
Dmitry
