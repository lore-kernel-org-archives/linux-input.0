From: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH] Input: edt-ft5x06 - fix error handling for factory mode
 on non-M06
Date: Wed, 24 Jan 2018 11:45:20 +0900
Message-ID: <20180124024520.GC1925@brancaleone.zhora.eu>
References: <20180123185236.fxjqpnscgx42s5lf@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 16.mo7.mail-out.ovh.net ([46.105.72.216]:43710 "EHLO
        16.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbeAXCzA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 Jan 2018 21:55:00 -0500
Received: from player788.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id 4316A87D9B
        for <linux-input@vger.kernel.org>; Wed, 24 Jan 2018 03:45:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180123185236.fxjqpnscgx42s5lf@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Simon Budig <simon.budig@kernelconcepts.de>, Andi Shyti <andi@etezian.org>, Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Mylene Josserand <mylene.josserand@free-electrons.com>, linux-kernel@vger.kernel.org

Hi Dmitry,

On Tue, Jan 23, 2018 at 10:52:36AM -0800, Dmitry Torokhov wrote:
> When attempting enter factory mode on firmware that does not support it,
> we'd error out, but leave the device with interrupts disabled, and thus
> touch not working. Fix it by moving the check before we disable
> interrupts/allocate memory for debug buffers.
> 
> Fixes: fd335ab04b3f ("Input: edt-ft5x06 - add support for M09 firmware version")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

makes sense!

Reviewed-by: Andi Shyti <andi@etezian.org>

Andi

> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index c53a3d7239e72..1e18ca0d1b4e1 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -511,6 +511,12 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
>  	int ret;
>  	int error;
>  
> +	if (tsdata->version != EDT_M06) {
> +		dev_err(&client->dev,
> +			"No factory mode support for non-M06 devices\n");
> +		return -EINVAL;
> +	}
> +
>  	disable_irq(client->irq);
>  
>  	if (!tsdata->raw_buffer) {
> @@ -524,9 +530,6 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
>  	}
>  
>  	/* mode register is 0x3c when in the work mode */
> -	if (tsdata->version != EDT_M06)
> -		goto m09_out;
> -
>  	error = edt_ft5x06_register_write(tsdata, WORK_REGISTER_OPMODE, 0x03);
>  	if (error) {
>  		dev_err(&client->dev,
> @@ -559,11 +562,6 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
>  	enable_irq(client->irq);
>  
>  	return error;
> -
> -m09_out:
> -	dev_err(&client->dev, "No factory mode support for M09/M12/GENERIC_FT\n");
> -	return -EINVAL;
> -
>  }
>  
>  static int edt_ft5x06_work_mode(struct edt_ft5x06_ts_data *tsdata)
> -- 
> 2.16.0.rc1.238.g530d649a79-goog
> 
> 
> -- 
> Dmitry
