From: danilokrummrich@dk-develop.de
Subject: Re: [PATCH v3] serio: PS/2 gpio bit banging driver for the serio bus
Date: Tue, 01 Aug 2017 21:23:39 +0200
Message-ID: <799c588b3be59d13cfaf508440704db9@dk-develop.de>
References: <20170801042614.24242-1-danilokrummrich@dk-develop.de>
 <20170801173207.GC28401@dtor-ws>
 <fb4c668518ac342f21f4c2eabd7db236@dk-develop.de>
 <20170801190744.GD28401@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs01.dk-develop.de ([213.136.71.231]:50705 "EHLO
        hs01.dk-develop.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752022AbdHATXf (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 1 Aug 2017 15:23:35 -0400
In-Reply-To: <20170801190744.GD28401@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linus.walleij@linaro.org, rdunlap@infradead.org

On 2017-08-01 21:07, Dmitry Torokhov wrote:
> On Tue, Aug 01, 2017 at 08:51:40PM +0200, danilokrummrich@dk-develop.de 
> wrote:
>> On 2017-08-01 19:32, Dmitry Torokhov wrote:
>> >On Tue, Aug 01, 2017 at 06:26:14AM +0200, Danilo Krummrich wrote:
>> >>+	irq = gpio_to_irq(drvdata->gpio_clk);
>> >>+	if (!irq) {
>> >>+		dev_err(dev, "cannot get irq from gpio %u\n",
>> >>+			drvdata->gpio_clk);
>> >>+		error = -ENXIO;
>> >>+		goto err_free_serio;
>> >>+	}
>> >
>> >
>> >IRQ line does not have to be the same as GPIO pin. Describe it
>> >separately in device properties and just do:
>> >
>> >	irq = platform_get_irq(pdev, 0);
>> >
>> >and use it in the request below.
>> >
>> In which constellation can they be different?
> 
> IIRC there are controllers that may not let you re-configure GPIO that
> is reserved for interrupt, for output. So you could have a bit of
> hardware logic that splits and isolates GPIO and interrupt line.
> 
> Also have the trigger come from the interrupt description as well in
> case you happen to have inverter logic there.
> 
Thanks for clarification, didn't knew that. So,I will take this in 
advance.
>> >>+
>> >>+	error = devm_request_irq(dev, irq, ps2_gpio_irq, IRQF_NO_THREAD |
>> >>+			IRQF_TRIGGER_FALLING, DRIVER_NAME, drvdata);
>> >
>> >This will not work if GPIO is behind I2C or other slow bus. Is it
>> >essential that there is no scheduling delay here?
>> >
>> Yes it is. You are right, this wouldn't work. Was this the scenario
>> you had in mind while
>> writing the comment above?
> 
> No, that was just a general comment about GPIO on slow busses. You 
> might
> need to check gpiod_can_sleep() and abort driver load if gpio is
> sleeping.
> 
Yes, I will do so.
> Thanks.
