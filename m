From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] Input: mms114 - Fix regulator enable and disable paths
Date: Sat, 02 Mar 2013 17:32:24 +0900
Message-ID: <5131B918.2040706@samsung.com>
References: <1362212456-21941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:19453 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab3CBIcA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 2 Mar 2013 03:32:00 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJ000FLYYDAZF60@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Sat, 02 Mar 2013 17:31:58 +0900 (KST)
In-reply-to: <1362212456-21941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On 03/02/2013 05:20 PM, Mark Brown wrote:
> When it uses regulators the mms114 driver checks to see if it managed to
> acquire regulators and ignores errors. This is not the intended usage and
> not great style in general.
>
> Since the driver already refuses to probe if it fails to allocate the
> regulators simply make the enable and disable calls unconditional and
> add appropriate error handling, including adding cleanup of the
> regulators if setup_reg() fails.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>   drivers/input/touchscreen/mms114.c |   34 +++++++++++++++++++++++++---------
>   1 file changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
> index 4a29ddf..662e34b 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -314,15 +314,27 @@ static int mms114_start(struct mms114_data *data)
>   	struct i2c_client *client = data->client;
>   	int error;
>   
> -	if (data->core_reg)
> -		regulator_enable(data->core_reg);
> -	if (data->io_reg)
> -		regulator_enable(data->io_reg);
> +	error = regulator_enable(data->core_reg);
> +	if (error != 0) {
> +		dev_err(&client->dev, "Failed to enable avdd: %d\n", error);
> +		return error;
> +	}
> +
> +	error = regulator_enable(data->io_reg);
> +	if (error != 0) {
> +		dev_err(&client->dev, "Failed to enable vdd: %d\n", error);
> +		regulator_disable(data->core_reg);
> +		return error;
> +	}
> +
>   	mdelay(MMS114_POWERON_DELAY);
>   
>   	error = mms114_setup_regs(data);
> -	if (error < 0)
> +	if (error < 0) {
> +		regulator_disable(data->io_reg);
> +		regulator_disable(data->core_reg);
>   		return error;
> +	}
>   
>   	if (data->pdata->cfg_pin)
>   		data->pdata->cfg_pin(true);
> @@ -335,16 +347,20 @@ static int mms114_start(struct mms114_data *data)
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

Thanks for fixing it.

Acked-by: Joonyoung Shim <jy0922.shim@samsung.com>
