From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 8/12] neo1973: button input device driver
Date: Thu, 3 Jan 2008 12:05:02 -0500
Message-ID: <d120d5000801030905h88b0edfy67c2f3fd562e3088@mail.gmail.com>
References: <20071218110807.GO29882@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:41825 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754084AbYACRFE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Jan 2008 12:05:04 -0500
Received: by mu-out-0910.google.com with SMTP id i10so4792405mue.5
        for <linux-input@vger.kernel.org>; Thu, 03 Jan 2008 09:05:02 -0800 (PST)
In-Reply-To: <20071218110807.GO29882@prithivi.gnumonks.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Harald Welte <laforge@openmoko.org>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org

Hi Harald,

Sorry for the slow response.

On Dec 18, 2007 6:08 AM, Harald Welte <laforge@openmoko.org> wrote:
> +
> +       input_dev->name = "Neo1973 Buttons";
> +       input_dev->phys = "neo1973kbd/input0";
> +       input_dev->id.bustype = BUS_HOST;
> +       input_dev->id.vendor = 0x0001;
> +       input_dev->id.product = 0x0001;
> +       input_dev->id.version = 0x0100;
> +       input_dev->cdev.dev = &pdev->dev;

Please use input_dev->dev.parent instead of cdev as it is going away.

> +       input_dev->private = neo1973kbd;

Please use input_set_drvdata() instead of accessing private directly.

> +out_aux:
> +       input_unregister_device(neo1973kbd->input);

Add neo1973kbd->input = NULL here, otherwise we'll end up doing
input_free_device after input_unregister_device which is no good
(unregister will free the device if it is the last reference).

> +out_register:
> +       input_free_device(neo1973kbd->input);
> +       platform_set_drvdata(pdev, NULL);
> +       kfree(neo1973kbd);
> +
> +       return -ENODEV;
> +}
> +
> +static int neo1973kbd_remove(struct platform_device *pdev)
> +{
> +       struct neo1973kbd *neo1973kbd = platform_get_drvdata(pdev);
> +
> +       free_irq(s3c2410_gpio_getirq(pdev->resource[2].start), neo1973kbd);
> +       free_irq(s3c2410_gpio_getirq(pdev->resource[1].start), neo1973kbd);
> +       free_irq(s3c2410_gpio_getirq(pdev->resource[0].start), neo1973kbd);
> +
> +       input_unregister_device(neo1973kbd->input);
> +       input_free_device(neo1973kbd->input);

Same here, input_free_device() is harmful here.

-- 
Dmitry
