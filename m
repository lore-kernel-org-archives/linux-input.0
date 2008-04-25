From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] atmel_tsadcc: Device driver for AT91SAM9RL
	Touchscreen
Date: Fri, 25 Apr 2008 16:34:48 -0400
Message-ID: <20080425162535.ZZRA012@mailhub.coreip.homeip.net>
References: <1209149798-20418-1-git-send-email-justin.waters@timesys.com> <1209149798-20418-2-git-send-email-justin.waters@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.243]:12046 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171AbYDYUew (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 16:34:52 -0400
Received: by hs-out-0708.google.com with SMTP id 4so2553620hsl.5
        for <linux-input@vger.kernel.org>; Fri, 25 Apr 2008 13:34:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1209149798-20418-2-git-send-email-justin.waters@timesys.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Justin Waters <justin.waters@timesys.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux@maxim.org.za

Hi Justin,

On Fri, Apr 25, 2008 at 02:56:37PM -0400, Justin Waters wrote:
> The atmel tsadcc is a touchscreen/adc controller found on the AT91SAM9RL SoC.
> This driver provides basic support for this controller for use as a
> touchscreen.  Some future improvements include suspend/resume capabilities and
> debugfs support.
> 
> Signed-off-by: Justin Waters <justin.waters@timesys.com>

Thank you for the patch. Some comments:

> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 35d4097..3302e27 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -18,4 +18,5 @@ obj-$(CONFIG_TOUCHSCREEN_USB_COMPOSITE)	+= usbtouchscreen.o
>  obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+= penmount.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
> +obj-$(CONFIG_TOUCHSCREEN_ATMEL_TSADCC)	+= atmel_tsadcc.o

If it was sorted alphabetically it would help me.

> +
> +		/* Pen remains down */
> +		atmel_tsadcc_getevent(ts);
> +
> +		input_report_abs(ts->input, ABS_X, ts->event.x);
> +		input_report_abs(ts->input, ABS_Y, ts->event.y);
> +		input_report_abs(ts->input, ABS_PRESSURE, 7500);
> +

The device does not really support pressure reading, please don't try
to provide fake reports. Signal touch with BTN_TOUCH.


> +static int __devexit atmel_tsadcc_remove(struct platform_device *pdev)
> +{
> +	struct atmel_tsadcc *ts = dev_get_drvdata(&pdev->dev);
> +
> +	input_unregister_device(ts->input);
> +
> +	free_irq(ts->irq, ts);

You should free IRQ first, otherwise IRQ may fire just was device is
unregistered and bad things may happed.

Also please run checkpatch on the driver since there are some
formatting and whitespace issues (note that I dont particularly care
about 80 column limit as long as code is readable).

Thank you. 

-- 
Dmitry
