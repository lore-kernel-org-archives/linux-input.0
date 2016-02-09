From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: edt-ft5x06 - fix setting gain, offset, and
 threshold via device tree
Date: Tue, 9 Feb 2016 09:33:17 -0800
Message-ID: <20160209173317.GA40460@dtor-ws>
References: <1455038558-27471-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35892 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757298AbcBIRdU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Feb 2016 12:33:20 -0500
Received: by mail-pf0-f174.google.com with SMTP id e127so35253581pfe.3
        for <linux-input@vger.kernel.org>; Tue, 09 Feb 2016 09:33:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455038558-27471-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Franklin S Cooper Jr <fcooper@ti.com>, linux-input@vger.kernel.org, kernel@pengutronix.de

On Tue, Feb 09, 2016 at 06:22:38PM +0100, Philipp Zabel wrote:
> A recent patch broke parsing the gain, offset, and threshold parameters
> from device tree. Instead of setting the cached values and writing them
> to the correct registers during probe, it would write the values from DT
> into the register address variables and never write them to the chip
> during normal operation.
> 
> Fixes: 2e23b7a96372 ("Input: edt-ft5x06 - use generic properties API")
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied, thank you.

> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 0b0f8c1..23fbe38 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -822,16 +822,22 @@ static void edt_ft5x06_ts_get_defaults(struct device *dev,
>  	int error;
>  
>  	error = device_property_read_u32(dev, "threshold", &val);
> -	if (!error)
> -		reg_addr->reg_threshold = val;
> +	if (!error) {
> +		edt_ft5x06_register_write(tsdata, reg_addr->reg_threshold, val);
> +		tsdata->threshold = val;
> +	}
>  
>  	error = device_property_read_u32(dev, "gain", &val);
> -	if (!error)
> -		reg_addr->reg_gain = val;
> +	if (!error) {
> +		edt_ft5x06_register_write(tsdata, reg_addr->reg_gain, val);
> +		tsdata->gain = val;
> +	}
>  
>  	error = device_property_read_u32(dev, "offset", &val);
> -	if (!error)
> -		reg_addr->reg_offset = val;
> +	if (!error) {
> +		edt_ft5x06_register_write(tsdata, reg_addr->reg_offset, val);
> +		tsdata->offset = val;
> +	}
>  }
>  
>  static void
> -- 
> 2.7.0.rc3
> 

-- 
Dmitry
