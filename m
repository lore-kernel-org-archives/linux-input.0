From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: tca8418 - Add support for shared interrupt
Date: Mon, 5 Nov 2012 10:58:06 -0800
Message-ID: <20121105185806.GA18149@core.coreip.homeip.net>
References: <1352132052-19771-1-git-send-email-alban.bedel@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:48060 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab2KES6L (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Nov 2012 13:58:11 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so2807930dak.19
        for <linux-input@vger.kernel.org>; Mon, 05 Nov 2012 10:58:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1352132052-19771-1-git-send-email-alban.bedel@avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alban Bedel <alban.bedel@avionic-design.de>
Cc: linux-input@vger.kernel.org

Hi Alban,

On Mon, Nov 05, 2012 at 05:14:12PM +0100, Alban Bedel wrote:
> Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
> ---
>  drivers/input/keyboard/tca8418_keypad.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
> index fc9cc94..5adc655 100644
> --- a/drivers/input/keyboard/tca8418_keypad.c
> +++ b/drivers/input/keyboard/tca8418_keypad.c
> @@ -225,16 +225,18 @@ static irqreturn_t tca8418_irq_handler(int irq, void *dev_id)
>  	if (error) {
>  		dev_err(&keypad_data->client->dev,
>  			"unable to read REG_INT_STAT\n");
> -		goto exit;
> +		return IRQ_NONE;
>  	}
>  
> +	if (!reg)
> +		return IRQ_NONE;
> +
>  	if (reg & INT_STAT_OVR_FLOW_INT)
>  		dev_warn(&keypad_data->client->dev, "overflow occurred\n");
>  
>  	if (reg & INT_STAT_K_INT)
>  		tca8418_read_keypad(keypad_data);
>  
> -exit:
>  	/* Clear all interrupts, even IRQs we didn't check (GPI, CAD, LCK) */
>  	reg = 0xff;
>  	error = tca8418_write_byte(keypad_data, REG_INT_STAT, reg);
> @@ -377,7 +379,9 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
>  		client->irq = gpio_to_irq(client->irq);
>  
>  	error = request_threaded_irq(client->irq, NULL, tca8418_irq_handler,
> -				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				     IRQF_TRIGGER_FALLING |
> +				     IRQF_SHARED |
> +				     IRQF_ONESHOT,
>  				     client->name, keypad_data);

I do not think that using ONESHOT IRQ handlers in shared interrupt
configuration is a good idea as that interrupt will stay masked until
the keypad is done processing it, which may take some time.

Thanks.

-- 
Dmitry
