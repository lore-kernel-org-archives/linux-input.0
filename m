From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH Resend] Input: mms114: Use devm_* APIs
Date: Wed, 9 Jan 2013 10:38:31 +0530
Message-ID: <50ECFB4F.8010501@nvidia.com>
References: <1357704948-25758-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:11769 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3AIFIz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jan 2013 00:08:55 -0500
In-Reply-To: <1357704948-25758-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "patches@linaro.org" <patches@linaro.org>, Joonyoung Shim <jy0922.shim@samsung.com>

On Wednesday 09 January 2013 09:45 AM, Sachin Kamat wrote:
> devm_* APIs are device managed and make the exit and clean up code
> simpler.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> ---

I think this is not resend patch, it is Patch V2. Also you can specify 
the changes done from last patch to this patch so that it will be easy 
to reviewer.

> +	data = devm_kzalloc(&client->dev, sizeof(struct mms114_data),
Because you are here, better to change the size to sizeof(*data) in 
place of sizeof(struct..)

> +			

> +	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +			mms114_interrupt, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +			"mms114", data);

Should be change to devname(&client->dev) in place of hardconding to 
"mms114".

>   	if (error) {
>   		dev_err(&client->dev, "Failed to register interrupt\n");
> -		goto err_io_reg;
> +		return error;
>   	}
>   	disable_irq(client->irq);
>   
>   	error = input_register_device(data->input_dev);
>   	if (error)

> -		
> +		return error;
>   
>   	return 0;


Seems the code turn as
if (error)
    return error;
return 0.

I think simply saying return error is fine here as you are not printing 
any error.
>   }
> @@ -590,7 +567,6 @@ static struct i2c_driver mms114_driver = {
>   		.of_match_table = of_match_ptr(mms114_dt_match),
>   	},
>   	.probe		= mms114_probe,
> -	.remove		= mms114_remove,
>   	.id_table	= mms114_id,
>   };
>   


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
