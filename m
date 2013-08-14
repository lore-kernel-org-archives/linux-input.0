From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] input: qt1070: add power management ops
Date: Wed, 14 Aug 2013 08:52:17 +0200
Message-ID: <520B2921.3000906@atmel.com>
References: <1376379826-28808-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:52400 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab3HNGwB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Aug 2013 02:52:01 -0400
In-Reply-To: <1376379826-28808-1-git-send-email-voice.shen@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: dmitry.torokhov@gmail.com, Wenyou.Yang@atmel.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On 13/08/2013 09:43, Bo Shen :
> Add power management ops for qt1070, it maybe a wakeup source
>
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>   drivers/input/keyboard/qt1070.c |   25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
> index 42b773b..deefe5a 100644
> --- a/drivers/input/keyboard/qt1070.c
> +++ b/drivers/input/keyboard/qt1070.c
> @@ -243,6 +243,30 @@ static int qt1070_remove(struct i2c_client *client)
>   	return 0;
>   }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int qt1070_suspend(struct device *dev)
> +{
> +	struct qt1070_data *data = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(data->irq);
> +
> +	return 0;
> +}
> +
> +static int qt1070_resume(struct device *dev)
> +{
> +	struct qt1070_data *data = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(data->irq);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(qt1070_pm_ops, qt1070_suspend, qt1070_resume);
> +
>   static const struct i2c_device_id qt1070_id[] = {
>   	{ "qt1070", 0 },
>   	{ },
> @@ -253,6 +277,7 @@ static struct i2c_driver qt1070_driver = {
>   	.driver	= {
>   		.name	= "qt1070",
>   		.owner	= THIS_MODULE,
> +		.pm	= &qt1070_pm_ops,
>   	},
>   	.id_table	= qt1070_id,
>   	.probe		= qt1070_probe,
>


-- 
Nicolas Ferre
