From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: ad7879: support auxiliary GPIOs via gpiolib
Date: Sun, 17 Jan 2010 22:35:07 -0800
Message-ID: <20100118063507.GA5012@core.coreip.homeip.net>
References: <20100113025456.GA2301@core.coreip.homeip.net>
 <1263742602-22250-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:57292 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab0ARGfO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2010 01:35:14 -0500
Received: by pxi12 with SMTP id 12so3105406pxi.33
        for <linux-input@vger.kernel.org>; Sun, 17 Jan 2010 22:35:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1263742602-22250-1-git-send-email-vapier@gentoo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

Hi Mike,

On Sun, Jan 17, 2010 at 10:36:42AM -0500, Mike Frysinger wrote:
> +
> +#ifdef CONFIG_GPIOLIB
> +int ad7879_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
>  {

Sparse recommends making this static and it seems like a good idea. The
same goes for the 3 new fucntions below.

> +
> +static inline int ad7879_gpio_add(struct device *dev)

Why inline? Let's compiler decide, it's certainly not a hot path.

> +{
> +	struct ad7879 *ts = dev_get_drvdata(dev);
> +	struct ad7879_platform_data *pdata = dev->platform_data;
> +	int ret = 0;
> +
> +	if (pdata->gpio_export) {
> +		ts->gc.direction_input = ad7879_gpio_direction_input;
> +		ts->gc.direction_output = ad7879_gpio_direction_output;
> +		ts->gc.get = ad7879_gpio_get_value;
> +		ts->gc.set = ad7879_gpio_set_value;
> +		ts->gc.can_sleep = 1;
> +		ts->gc.base = pdata->gpio_base;
> +		ts->gc.ngpio = 1;
> +		ts->gc.label = "AD7879-GPIO";
> +		ts->gc.owner = THIS_MODULE;
> +		ts->gc.dev = dev;
> +
> +		ret = gpiochip_add(&ts->gc);
> +		if (ret)
> +			dev_err(dev, "failed to register gpio %d\n",
> +				ts->gc.base);
> +	}
> +
> +	return ret;
> +}
> +
> +static int ad7879_gpio_remove(struct device *dev)

There is no chance we can handle errors returned by this function so I'd
make it 'void'.

Let me know if you agree with the above, there is no need to resubmit.

Thanks.

-- 
Dmitry
