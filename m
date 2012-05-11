From: Josh Wu <josh.wu@atmel.com>
Subject: Re: [RFC] QT1070: change the trigger mode of QT1070
Date: Fri, 11 May 2012 16:07:12 +0800
Message-ID: <4FACC8B0.4040606@atmel.com>
References: <1336357653-18663-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:29347 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab2EKIIK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 04:08:10 -0400
In-Reply-To: <1336357653-18663-1-git-send-email-voice.shen@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: dmitry.torokhov@gmail.com, javier.martin@vista-silicon.com, khali@linux-fr.org, w.sang@pengutronix.de, jm.lin@atmel.com, linux-input@vger.kernel.org

Hi, Bo

On 5/7/2012 10:27 AM, Bo Shen wrote:

> The default trigger mode of QT1070 is IRQF_TRIGGER_LOW,
> Using TRQF_TRIGGER_FALLING to replace IRQF_TRIGGER_LOW | IRQF_ONESHOT.
>
> Add a workaround for some SOC which can not distinguish the falling
> and rising change on I/O lines.
>
> Signed-off-by: Bo Shen<voice.shen@atmel.com>
> ---
>   drivers/input/keyboard/qt1070.c |   13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
> index 0b7b2f8..1855e3d 100644
> --- a/drivers/input/keyboard/qt1070.c
> +++ b/drivers/input/keyboard/qt1070.c
> @@ -201,10 +201,17 @@ static int __devinit qt1070_probe(struct i2c_client *client,
>   	msleep(QT1070_RESET_TIME);
>
>   	err = request_threaded_irq(client->irq, NULL, qt1070_interrupt,
> -		IRQF_TRIGGER_NONE, client->dev.driver->name, data);
> +		IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
>   	if (err) {
> -		dev_err(&client->dev, "fail to request irq\n");
> -		goto err_free_mem;
> +		/* This is a workaround for some SOC which can not distinguish
> +		 * falling and rising change on I/O lines.
> +		 */
> +		err = request_threaded_irq(client->irq, NULL, qt1070_interrupt,
> +			IRQF_TRIGGER_NONE, client->dev.driver->name, data);

I think here using IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING is better 
than using IRQF_TRIGGER_NONE.
Since for the QT1070 driver it can handle irq interrupt of falling (can 
read valid data from QT1070) or rising (read but no valid data).
But if set to IRQF_TRIGGER_NONE, for some hardware it maybe caused by 
IRQF_TRIGGER_HIGH or IRQF_TRIGGER_LOW. That is not what you expected.

> +		if (err) {
> +			dev_err(&client->dev, "fail to request irq\n");
> +			goto err_free_mem;
> +		}
>   	}
>
>   	/* Register the input device */

Best Regards,
Josh Wu
