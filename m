From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH v2] Input: ad7879: support auxiliary GPIOs via gpiolib
Date: Wed, 13 Jan 2010 09:46:42 +0000
Message-ID: <8A42379416420646B9BFAC9682273B6D0F0DF094@limkexm3.ad.analog.com>
References: <20100107073114.GC2314@core.coreip.homeip.net> <1263330297-1387-1-git-send-email-vapier@gentoo.org> <20100113025456.GA2301@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:48854 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab0AMJqp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2010 04:46:45 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <20100113025456.GA2301@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>
Cc: linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

>From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>
>Hi Mike,
>
>On Tue, Jan 12, 2010 at 04:04:57PM -0500, Mike Frysinger wrote:
>> +
>> +		err = gpiochip_add(&ts->gc);
>> +		if (err)
>> +			dev_err(&bus->dev, "failed to register gpio
%d\n",
>> +				ts->gc.base);
>> +	}
>
>So if it fails here...
>
>> +	struct ad7879_platform_data *pdata = bus->dev.platform_data;
>> +	if (pdata->gpio_export) {
>> +		if (gpiochip_remove(&ts->gc))
>> +			dev_err(&bus->dev, "failed to remove gpio %d\n",
>> +				ts->gc.base);
>
>... how valid is it to remove it here?

Right - I should use a flag to sense whether the gpiochip was added or
not.

>
>Also, could you stub out
>ad7879_gptiochip_export/ad7879_gptiochip_unexport
>in case of !CONFIG_GPIOLIB?

Can you explain - where do you see those?


>
>> +	}
>> +#endif
>> +
>>  	ad7879_disable(ts);
>>  	sysfs_remove_group(&ts->bus->dev.kobj, &ad7879_attr_group);
>>  	free_irq(ts->bus->irq, ts);
>> diff --git a/include/linux/spi/ad7879.h b/include/linux/spi/ad7879.h
>> index 4231104..7231eab 100644
>> --- a/include/linux/spi/ad7879.h
>> +++ b/include/linux/spi/ad7879.h
>> @@ -28,8 +28,12 @@ struct ad7879_platform_data {
>>  	 * 1 = 4, 2 = 8, 3 = 16 (median > averaging)
>>  	 */
>>  	u8	median;
>> -	/* 1 = AUX/VBAT/GPIO set to GPIO Output */
>> -	u8	gpio_output;
>> -	/* Initial GPIO pin state (valid if gpio_output = 1) */
>> -	u8	gpio_default;
>> +	/* 1 = AUX/VBAT/GPIO export GPIO to gpiolib
>> +	 * requires CONFIG_GPIOLIB
>> +	 */
>> +	u8	gpio_export;
>
>And make this a bool while you are at it.
>
>Thanks!
>
>--
>Dmitry

-Michael
