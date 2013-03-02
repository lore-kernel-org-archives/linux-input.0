From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] Input: mms114 - Fix regulator enable and disable paths
Date: Sat, 02 Mar 2013 17:11:00 +0900
Message-ID: <5131B414.1080204@samsung.com>
References: <1362207641-25152-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:65470 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab3CBIVs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 2 Mar 2013 03:21:48 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJ000E8MXDAJ230@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Sat, 02 Mar 2013 17:10:33 +0900 (KST)
In-reply-to: <1362207641-25152-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Mark,

On 03/02/2013 04:00 PM, Mark Brown wrote:
> When it uses regulators the mms114 driver checks to see if it managed to
> acquire regulators and ignores errors. This is not the intended usage and
> not great style in general.
>
> Since the driver already refuses to probe if it fails to allocate the
> regulators simply make the enable and disable calls unconditional and
> add appropriate error handling.

Right.

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>   drivers/input/touchscreen/mms114.c |   31 +++++++++++++++++++++++--------
>   1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
> index 4a29ddf..bb95c89 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -314,10 +314,21 @@ static int mms114_start(struct mms114_data *data)
>   	struct i2c_client *client = data->client;
>   	int error;
>   
> -	if (data->core_reg)
> -		regulator_enable(data->core_reg);
> -	if (data->io_reg)
> -		regulator_enable(data->io_reg);
> +	error = regulator_enable(data->core_reg);
> +	if (error != 0) {
> +		dev_err(&client->dev, "Failed to enable avdd: %d\n",
> +			error);

Could you make this to one line?

> +		return error;
> +	}
> +
> +	error = regulator_enable(data->io_reg);
> +	if (error != 0) {
> +		dev_err(&client->dev, "Failed to enable vdd: %d\n",
> +			error);

Ditto.

> +		regulator_disable(data->core_reg);
> +		return error;
> +	}
> +
>   	mdelay(MMS114_POWERON_DELAY);
>   
>   	error = mms114_setup_regs(data);

If error, we will have to disable regulators here.

> @@ -335,16 +346,20 @@ static int mms114_start(struct mms114_data *data)
>   static void mms114_stop(struct mms114_data *data)
>   {
>   	struct i2c_client *client = data->client;
> +	int error;
>   
>   	disable_irq(client->irq);
>   
>   	if (data->pdata->cfg_pin)
>   		data->pdata->cfg_pin(false);
>   
> -	if (data->io_reg)
> -		regulator_disable(data->io_reg);
> -	if (data->core_reg)
> -		regulator_disable(data->core_reg);
> +	error = regulator_disable(data->io_reg);
> +	if (error != 0)
> +		dev_warn(&client->dev, "Failed to disable vdd: %d\n", error);
> +
> +	error = regulator_disable(data->core_reg);
> +	if (error != 0)
> +		dev_warn(&client->dev, "Failed to disable avdd: %d\n", error);
>   }
>   
>   static int mms114_input_open(struct input_dev *dev)

Thanks.
