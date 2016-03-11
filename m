From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] da9052: ensure da9052_ts_input_open will not lock up on
 irq flood
Date: Fri, 11 Mar 2016 11:33:11 -0800
Message-ID: <20160311193311.GD13175@dtor-ws>
References: <1457002322-21953-1-git-send-email-m.grzeschik@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35256 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbcCKTdO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2016 14:33:14 -0500
Received: by mail-pf0-f170.google.com with SMTP id n5so52477710pfn.2
        for <linux-input@vger.kernel.org>; Fri, 11 Mar 2016 11:33:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1457002322-21953-1-git-send-email-m.grzeschik@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: linux-input@vger.kernel.org, support.opensource@diasemi.com, kernel@pengutronix.de

On Thu, Mar 03, 2016 at 11:52:02AM +0100, Michael Grzeschik wrote:
> It is possible that da9052_ts_input_open is called and the touchscreen
> is triggering continuous interrupts. In this case we will never leave
> da9052_ts_input_open. The da9052_reg_update will never get the i2c bus
> as the interrupt handler will continuously lock it.
> 
> This patch switch places of da9052_reg_update and the setting of
> tsi->stopped. This way its ensured that da9052_ts_input_open will never
> lockup on interrupt flood.

I understand what you are saying about updating register, however I do
not understand why we would want to swap unmasking pendown event ans
clearing the "stopped" flag.

Thanks.

> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  drivers/input/touchscreen/da9052_tsi.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
> index 5a013bb..1b136b8 100644
> --- a/drivers/input/touchscreen/da9052_tsi.c
> +++ b/drivers/input/touchscreen/da9052_tsi.c
> @@ -189,17 +189,20 @@ static int da9052_configure_tsi(struct da9052_tsi *tsi)
>  
>  static int da9052_ts_input_open(struct input_dev *input_dev)
>  {
> +	int val;
>  	struct da9052_tsi *tsi = input_get_drvdata(input_dev);
>  
> -	tsi->stopped = false;
> -	mb();
> +	val = da9052_reg_update(tsi->da9052, DA9052_TSI_CONT_A_REG,
> +				 1 << 1, 1 << 1);
>  
>  	/* Unmask PEN_DOWN event */
>  	da9052_enable_irq(tsi->da9052, DA9052_IRQ_PENDOWN);
>  
> +	tsi->stopped = false;
> +	mb();
> +
>  	/* Enable Pen Detect Circuit */
> -	return da9052_reg_update(tsi->da9052, DA9052_TSI_CONT_A_REG,
> -				 1 << 1, 1 << 1);
> +	return val;
>  }
>  
>  static void da9052_ts_input_close(struct input_dev *input_dev)
> -- 
> 2.7.0
> 

-- 
Dmitry
