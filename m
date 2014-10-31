From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 14/15] gpio: locomo: implement per-pin irq handling
Date: Fri, 31 Oct 2014 13:35:18 +0400
Message-ID: <CALT56yM7yp7N04BSk9GZOObLSxaKepy5njRHQHOe3-bRSX3yQA@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
	<1414454528-24240-15-git-send-email-dbaryshkov@gmail.com>
	<CACRpkdamVriR9kJSeY=LVAx7ADukT8+GpqmNH9YMnL3OKUk8iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:51648 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbaJaJfT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 05:35:19 -0400
In-Reply-To: <CACRpkdamVriR9kJSeY=LVAx7ADukT8+GpqmNH9YMnL3OKUk8iw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo

2014-10-31 11:00 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Oct 28, 2014 at 1:02 AM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>
>> LoCoMo has a possibility to generate per-GPIO edge irqs. Support for
>> that was there in old locomo driver, got 'cleaned up' during old driver
>> IRQ cascading cleanup and is now reimplemented. It is expected that
>> SL-5500 (collie) will use locomo gpio irqs for mmc detection irq.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>
> Please don't use open-coded IRQ handling like this, we are moving
> away from that.
>
> In Kconfig,
>
> select GPIOLIB_IRQCHIP
>
> and look at the other drivers selecting this for inspiration. There
> is even some documentation in Documentation/gpio/driver.txt
>
> You will find that it cuts down a lot of overhead from your driver
> and does everything in the right way in a central place.

Thanks, I will take a look.
[Skipped the rest of the comments mostly dedicated to gpiolib_irqchip].


-- 
With best wishes
Dmitry
