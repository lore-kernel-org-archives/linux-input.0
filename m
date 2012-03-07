From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v4] Touchscreen driver for FT5x06 based EDT displays
Date: Wed, 7 Mar 2012 14:36:52 +0100
Message-ID: <20120307143652.3f7335f8@wker>
References: <1326413588-30517-1-git-send-email-simon.budig@kernelconcepts.de>
	<1331050527-4902-1-git-send-email-simon.budig@kernelconcepts.de>
	<1331050527-4902-2-git-send-email-simon.budig@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:34676 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755616Ab2CGNhF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Mar 2012 08:37:05 -0500
In-Reply-To: <1331050527-4902-2-git-send-email-simon.budig@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon.budig@kernelconcepts.de
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, yanok@emcraft.com, b.van.den.berg.nl@gmail.com

Hi Simon,

thanks for reworking. I've tested the driver on our board, now it
also works with our pin configuration. I have some minor comments,
please see below.

On Tue,  6 Mar 2012 17:15:27 +0100
simon.budig@kernelconcepts.de wrote:

> From: Simon Budig <simon.budig@kernelconcepts.de>
> 
> This is a driver for the EDT "Polytouch" family of touch controllers
> based on the FocalTech FT5x06 line of chips.
> 
> Signed-off-by: Simon Budig <simon.budig@kernelconcepts.de>
> ---
...
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> new file mode 100644
> index 0000000..eb31025
> --- /dev/null
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
...
> +	tsdata->reset_pin = pdata->reset_pin;
> +	mutex_init(&tsdata->mutex);
> +
> +	if (tsdata->reset_pin >= 0) {
> +		error = gpio_request(tsdata->reset_pin, NULL);

It would be helpful to have labels for requested gpio pins. Can you pass
"ft5x06 reset" instead of NULL here?

> +		if (error < 0) {
> +			dev_err(&client->dev,
> +			        "Failed to request GPIO %d as reset pin, error %d\n",
> +			         tsdata->reset_pin, error);
> +			error = -ENOMEM;

Please drop this 'error = -ENOMEM;'. We should return
error code returned by gpio_request() here.

> +			goto err_free_tsdata;
> +		}
> +
> +		/* this pulls reset down, enabling the low active reset */
> +		if (gpio_direction_output(tsdata->reset_pin, 0) < 0) {
> +			dev_info(&client->dev, "switching to output failed\n");
> +			goto err_free_reset_pin;
> +		}
> +	}
> +
> +	/* request IRQ pin */
> +	tsdata->irq_pin = pdata->irq_pin;
> +	tsdata->irq = gpio_to_irq(tsdata->irq_pin);
> +
> +	error = gpio_request(tsdata->irq_pin, NULL);

gpio pin label, too?

Thanks,
Anatolij
