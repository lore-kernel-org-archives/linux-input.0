From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [patch] Input: edt-ft5x06 - add a missing condition
Date: Thu, 03 Apr 2014 10:14:43 +0900
Message-ID: <002101cf4eda$184e85b0$48eb9110$%han@samsung.com>
References: <20140402165354.GA9970@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-reply-to: <20140402165354.GA9970@mwanda>
Content-language: ko
Sender: kernel-janitors-owner@vger.kernel.org
To: 'Dan Carpenter' <dan.carpenter@oracle.com>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, =?ISO-8859-1?Q?'Lothar_Wa=DFmann'?= <LW@KARO-electronics.de>, 'Henrik Rydberg' <rydberg@euromail.se>, 'Grant Likely' <grant.likely@linaro.org>, 'Rob Herring' <robh+dt@kernel.org>, 'Fugang Duan' <B38611@freescale.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-input@vger.kernel.org

On Thursday, April 03, 2014 1:54 AM, Dan Carpenter wrote:
> 
> The if condition was accidentally deleted here so we return every time
> instead of returning on error.
> 
> Fixes: fd335ab04b3f ('Input: edt-ft5x06 - add support for M09 firmware version')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 75b666b..9d0b324 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -291,9 +291,10 @@ static int edt_ft5x06_register_read(struct edt_ft5x06_ts_data *tsdata,
>  		wrbuf[1] = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
>  		wrbuf[1] |= tsdata->factory_mode ? 0x80 : 0x40;
> 
> -		error = edt_ft5x06_ts_readwrite(tsdata->client,
> -						2, wrbuf, 2, rdbuf);
> -		return error;
> +		error = edt_ft5x06_ts_readwrite(tsdata->client,	2, wrbuf, 2,
                                                                                 ^^^^^^
I think that 'tab' is not necessary between "client," and "2,".
Others look good.

Best regards,
Jingoo Han

> +						rdbuf);
> +		if (error)
> +			return error;
> 
>  		if ((wrbuf[0] ^ wrbuf[1] ^ rdbuf[0]) != rdbuf[1]) {
>  			dev_err(&tsdata->client->dev,

