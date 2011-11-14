From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH] edt_ts: EDT Touchscreen driver
Date: Tue, 15 Nov 2011 01:07:57 +0400
Message-ID: <4EC1832D.3080405@emcraft.com>
References: <1320795279-2018-1-git-send-email-yanok@emcraft.com> <20111114172809.GD12659@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:38317 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755759Ab1KNVrJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 16:47:09 -0500
In-Reply-To: <20111114172809.GD12659@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, Anatolij Gustshin <agust@denx.de>

Hi Dmitry,

On 14.11.2011 21:28, Dmitry Torokhov wrote:
>> +	irq = gpio_to_irq(pdata->irq_gpio);
>> +	if (irq < 0) {
>> +		dev_err(&client->dev, "can't get IRQ for GPIO\n");
>> +		error = -EINVAL;
>> +		goto err0;
>> +	}
> 
> Why can't we use client->irq?

Well, my idea was to avoid duplication (passing both GPIO and IRQ
numbers) and I can't pass only client->irq as we need GPIO number also
and irq_to_gpio is not guaranteed to work with arbitrary IRQ number.

Thanks for your comments! I'll address them and repost the patch.

Regards, Ilya.
