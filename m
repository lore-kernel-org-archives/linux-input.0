From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: qt2160: Add support for LEDs.
Date: Tue, 16 Oct 2012 08:53:20 -0700
Message-ID: <1693540.1O90RJqgga@dtor-d630.eng.vmware.com>
References: <1350400771-7950-1-git-send-email-javier.martin@vista-silicon.com> <1350400771-7950-2-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41014 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304Ab2JPPx0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Oct 2012 11:53:26 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so6041958pad.19
        for <linux-input@vger.kernel.org>; Tue, 16 Oct 2012 08:53:25 -0700 (PDT)
In-Reply-To: <1350400771-7950-2-git-send-email-javier.martin@vista-silicon.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: linux-input@vger.kernel.org, axel.lin@gmail.com

Hi Javier,

On Tuesday, October 16, 2012 05:19:31 PM Javier Martin wrote:
> Outputs x8..x0 of the qt2160 can have leds attached to it.
> This patch handles those outputs using EV_LED events.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---
>  drivers/input/keyboard/qt2160.c |   38
> ++++++++++++++++++++++++++++++++++++++ 1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/input/keyboard/qt2160.c
> b/drivers/input/keyboard/qt2160.c index 73ea4b0..7070372 100644
> --- a/drivers/input/keyboard/qt2160.c
> +++ b/drivers/input/keyboard/qt2160.c
> @@ -39,6 +39,7 @@
>  #define QT2160_CMD_GPIOS      6
>  #define QT2160_CMD_SUBVER     7
>  #define QT2160_CMD_CALIBRATE  10
> +#define QT2160_CMD_LEDS       70
> 
>  #define QT2160_CYCLE_INTERVAL	(2*HZ)
> 
> @@ -217,6 +218,30 @@ static int __devinit qt2160_write(struct i2c_client
> *client, u8 reg, u8 data) return ret;
>  }
> 
> +static int qt2160_event(struct input_dev *dev,
> +			unsigned int type, unsigned int code, int value)
> +{
> +	struct qt2160_data *qt2160 = input_get_drvdata(dev);
> +	struct i2c_client *client = qt2160->client;
> +	u32 val;
> +
> +	switch (type) {
> +	case EV_LED:
> +		val = qt2160_read(qt2160->client, QT2160_CMD_LEDS);
> +		if (value)
> +			val |= (1 << code);
> +		else
> +			val &= ~(1 << code);

So qt2160 happens to use the same encoding as Linux and the leds
have the same purpose? Or maybe LED subsystem should be used to
register general-purpose leds?

> +		qt2160_write(qt2160->client, QT2160_CMD_LEDS, val);

I do not think this will work as qt2160_event() runs under a spinlock
with interrupts off, and qt2160_read() and qt2160_write() do I2C IO
and thus may sleep.

Also qt2160_write is marked __devinit and so may not be available to
qt2160_event.

How was this tested?

Thanks.

-- 
Dmitry
