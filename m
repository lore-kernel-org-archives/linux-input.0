From: Josh Wu <josh.wu@atmel.com>
Subject: Re: qt1070: Why IRQF_TRIGGER_NONE?
Date: Thu, 03 May 2012 09:41:11 +0800
Message-ID: <4FA1E237.2070404@atmel.com>
References: <CACKLOr1XE+tJ92jbfOHdDQVVsXhsNASrHgENEbiuR+8aBE11cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:23178 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494Ab2ECBmC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 May 2012 21:42:02 -0400
In-Reply-To: <CACKLOr1XE+tJ92jbfOHdDQVVsXhsNASrHgENEbiuR+8aBE11cw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: javier Martin <javier.martin@vista-silicon.com>, "Shen, Voice" <Voice.Shen@atmel.com>
Cc: linux-input@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Jean Delvare <khali@linux-fr.org>, Axel Lin <axel.lin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On 5/2/2012 4:35 PM, javier Martin wrote:
> Hi,
> I was testing qt1070 driver with my Visstrim SM10 board when I found
> out IRQs where not triggered properly.
>
> I had to come up with the following patch in order to solve it:
>
> diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
> index 0b7b2f8..e8b6ae3 100644
> --- a/drivers/input/keyboard/qt1070.c
> +++ b/drivers/input/keyboard/qt1070.c
> @@ -201,7 +201,7 @@ static int __devinit qt1070_probe(struct i2c_client *client,
>   	msleep(QT1070_RESET_TIME);
>
>   	err = request_threaded_irq(client->irq, NULL, qt1070_interrupt,
> -		IRQF_TRIGGER_NONE, client->dev.driver->name, data);
> +		IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
>   	if (err) {
>   		dev_err(&client->dev, "fail to request irq\n");
>   		goto err_free_mem;
>
>
> According to the datasheet (p10)  "The CHANGE line is active low and
> signals when there is a change in state in the Detection or
> Input status bytes. It is cleared (allowed to float high) when the
> host reads the status bytes." As I understand, this means that we have
> to monitor falling edges here.
>
> Is there any reason to register the IRQ as IRQF_TRIGGER_NONE? Would
> you accept the above patch instead, provided I send it in the required
> format?
I add Voice Shen to the mail loop, who is writing above code.

Voice, will that IRQF_TRIGGER_XXXX changes impact other platforms?

Best Regards,
Josh Wu
>
> Regards.

