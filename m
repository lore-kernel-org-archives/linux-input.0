From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/5] Input: bu21013_ts - Move GPIO init and exit
 functions into the driver
Date: Wed, 21 Nov 2012 10:42:56 -0800
Message-ID: <20121121184256.GD18950@core.coreip.homeip.net>
References: <1352900837-20759-1-git-send-email-lee.jones@linaro.org>
 <1352900837-20759-3-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42158 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691Ab2KUSnA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 13:43:00 -0500
Content-Disposition: inline
In-Reply-To: <1352900837-20759-3-git-send-email-lee.jones@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Lee,

On Wed, Nov 14, 2012 at 01:47:14PM +0000, Lee Jones wrote:
> @@ -272,6 +276,60 @@ static irqreturn_t bu21013_gpio_irq(int irq, void *device_data)
>  }
>  
>  /**
> + * bu21013_gpio_board_init() - configures the touch panel
> + * @reset_pin: reset pin number
> + *
> + * This function is used to configure the voltage and
> + * reset the touch panel controller.
> + */
> +static int bu21013_gpio_board_init(int reset_pin)
> +{
> +	int retval = 0;
> +
> +	bu21013_devices++;
> +	if (bu21013_devices == 1) {

This does not make sense. If gpio is per-device now then we should
simply set it up and not count devices.

Thanks.

-- 
Dmitry
