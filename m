From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2] Input: goodix - disable IRQs while suspended
Date: Thu, 11 Jan 2018 16:52:34 +0100
Message-ID: <1515685954.3261.3.camel@hadess.net>
References: <20180111141211.16888-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39335 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932361AbeAKPwj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 11 Jan 2018 10:52:39 -0500
In-Reply-To: <20180111141211.16888-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

On Thu, 2018-01-11 at 15:12 +0100, Hans de Goede wrote:
> We should not try to do any i2c transfers before the controller is
> resumed (which happens before our resume method gets called).
> 
> So we need to disable our IRQ while suspended to enforce this. The
> code paths for devices with GPIOs for the int and reset pins already
> disable the IRQ the through goodix_free_irq().
> 
> This commit also disables the IRQ while suspended for devices without
> GPIOs for the int and reset pins.
> 
> This fixes the i2c bus sometimes getting stuck after a suspend/resume
> causing the touchscreen to sometimes not work after a suspend/resume.
> This has been tested on a GPD pocked device.

pocket?

Reviewed-by: Bastien Nocera <hadess@hadess.net>

> BugLink: https://github.com/nexus511/gpd-ubuntu-packages/issues/10
> BugLink: https://www.reddit.com/r/GPDPocket/comments/7niut2/fix_for_b
> roken_touch_after_resume_all_linux/
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Mention the problems this fix + devices tested on in commit msg
> -Add BugLinks and Tested-by to commit msg
> ---
>  drivers/input/touchscreen/goodix.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c
> b/drivers/input/touchscreen/goodix.c
> index 69d0b8cbc71f..ecec8eb17f28 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -878,8 +878,10 @@ static int __maybe_unused goodix_suspend(struct
> device *dev)
>  	int error;
>  
>  	/* We need gpio pins to suspend/resume */
> -	if (!ts->gpiod_int || !ts->gpiod_rst)
> +	if (!ts->gpiod_int || !ts->gpiod_rst) {
> +		disable_irq(client->irq);
>  		return 0;
> +	}
>  
>  	wait_for_completion(&ts->firmware_loading_complete);
>  
> @@ -919,8 +921,10 @@ static int __maybe_unused goodix_resume(struct
> device *dev)
>  	struct goodix_ts_data *ts = i2c_get_clientdata(client);
>  	int error;
>  
> -	if (!ts->gpiod_int || !ts->gpiod_rst)
> +	if (!ts->gpiod_int || !ts->gpiod_rst) {
> +		enable_irq(client->irq);
>  		return 0;
> +	}
>  
>  	/*
>  	 * Exit sleep mode by outputting HIGH level to INT pin
