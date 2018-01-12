From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: goodix - disable IRQs while suspended
Date: Fri, 12 Jan 2018 00:37:03 -0800
Message-ID: <20180112083703.eleyoh4vxm4ju45v@dtor-ws>
References: <20180111172407.7558-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:38333 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754369AbeALIhH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 12 Jan 2018 03:37:07 -0500
Received: by mail-it0-f68.google.com with SMTP id r6so8356687itr.3
        for <linux-input@vger.kernel.org>; Fri, 12 Jan 2018 00:37:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180111172407.7558-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bastien Nocera <hadess@hadess.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Thu, Jan 11, 2018 at 06:24:07PM +0100, Hans de Goede wrote:
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
> 
> BugLink: https://github.com/nexus511/gpd-ubuntu-packages/issues/10
> BugLink: https://www.reddit.com/r/GPDPocket/comments/7niut2/fix_for_broken_touch_after_resume_all_linux/
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Bastien Nocera <hadess@hadess.net>

Applied, thank you.

> ---
> Changes in v2:
> -Mention the problems this fix + devices tested on in commit msg
> -Add BugLinks and Tested-by to commit msg
> 
> Changes in v3:
> -Fix typo in commit msg
> -Add Bastien's Reviewed-by
> ---
>  drivers/input/touchscreen/goodix.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index 69d0b8cbc71f..ecec8eb17f28 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -878,8 +878,10 @@ static int __maybe_unused goodix_suspend(struct device *dev)
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
> @@ -919,8 +921,10 @@ static int __maybe_unused goodix_resume(struct device *dev)
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
> -- 
> 2.14.3
> 

-- 
Dmitry
