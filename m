From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/2] input: Add support for the Semtech SX8634
 controller
Date: Mon, 23 Jul 2012 09:48:16 -0700
Message-ID: <20120723164816.GA26577@core.coreip.homeip.net>
References: <1343045927-22063-1-git-send-email-thierry.reding@avionic-design.de>
 <1343045927-22063-2-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55773 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190Ab2GWQsW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Jul 2012 12:48:22 -0400
Received: by pbbrp8 with SMTP id rp8so11133590pbb.19
        for <linux-input@vger.kernel.org>; Mon, 23 Jul 2012 09:48:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343045927-22063-2-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-input@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@lists.ozlabs.org

Hi Thierry,

On Mon, Jul 23, 2012 at 02:18:47PM +0200, Thierry Reding wrote:
> +
> +	if (gpio_is_valid(sx->power_gpio)) {
> +		err = gpio_request(sx->power_gpio, "sx8634 power");
> +		if (err < 0) {
> +			dev_err(&client->dev,
> +				"failed to request power GPIO#%u: %d\n",
> +				sx->power_gpio, err);
> +			goto free_input_device;
> +		}
> +
> +		err = gpio_direction_output(sx->power_gpio, 1);
> +		if (err < 0) {
> +			dev_err(&client->dev, "failed to enable power: %d\n",
> +				err);
> +			goto free_power_gpio;
> +		}

I think there is gpio_request_one() that will take care of tehse 2
calls.

> +
> +		msleep(150);
> +	}
> +
> +	err = sx8634_setup(sx, pdata);
> +	if (err < 0)
> +		goto free_power_gpio;
> +
> +	err = sysfs_create_group(&client->dev.kobj, &sx8634_attr_group);
> +	if (err < 0)
> +		goto free_power_gpio;
> +
> +	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					sx8634_irq, IRQF_ONESHOT, "sx8634",
> +					sx);

Please do not use devm_* interface here as it make the driverr bomb in
remove() where you unregister input device but keep interrupt handler
active until after remove() finishes.

> +
> +#ifdef CONFIG_PM_SLEEP
> +static int sx8634_i2c_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int sx8634_i2c_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(sx8634_i2c_pm, sx8634_i2c_suspend, sx8634_i2c_resume);

Why are these stubs needed?

Thanks.

-- 
Dmitry
