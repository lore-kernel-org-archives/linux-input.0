From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: edt-ft5x06, Add i2c device ids
Date: Fri, 20 Feb 2015 10:32:50 -0800
Message-ID: <20150220183250.GA20060@dtor-glaptop>
References: <1424447785-14337-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34961 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612AbbBTScx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 13:32:53 -0500
Received: by pdbfl12 with SMTP id fl12so9391662pdb.2
        for <linux-input@vger.kernel.org>; Fri, 20 Feb 2015 10:32:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1424447785-14337-1-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, linux-input@vger.kernel.org, kernel@pengutronix.de

Hi Markus,

On Fri, Feb 20, 2015 at 04:56:25PM +0100, Markus Pargmann wrote:
> These ids are necessary to use edt-ft5x06 as a kernel module. Otherwise
> it is not loaded automatically in userspace because the ids do not match.
> 

We already have all module aliases needed, please fix i2c to generate modalias
for devices described in OF properly.

> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index d4c24fb7704f..63ad6d545bbe 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -1119,6 +1119,9 @@ static SIMPLE_DEV_PM_OPS(edt_ft5x06_ts_pm_ops,
>  
>  static const struct i2c_device_id edt_ft5x06_ts_id[] = {
>  	{ "edt-ft5x06", 0, },
> +	{ "edt-ft5206", 0, },
> +	{ "edt-ft5306", 0, },
> +	{ "edt-ft5406", 0, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(i2c, edt_ft5x06_ts_id);
> -- 
> 2.1.4
> 

Thanks.

-- 
Dmitry
