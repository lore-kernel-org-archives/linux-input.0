From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] Input: ar1021-i2c - fix too long name in driver's
 device table
Date: Tue, 13 Dec 2016 15:06:32 +0100
Message-ID: <1481637992.4190.7.camel@chaos.suse>
References: <20161212235702.GA10843@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933127AbcLMOGi (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Dec 2016 09:06:38 -0500
In-Reply-To: <20161212235702.GA10843@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, m.frohiky@gmail.com, Christian Gmeiner <christian.gmeiner@gmail.com>

Hi Dmitry,

On lun., 2016-12-12 at 15:57 -0800, Dmitry Torokhov wrote:
> The name field in structure i2c_device_id is 20 characters, and we
> expect it to be NULL-terminated, however we are trying to stuff it with
> 21 bytes and thus NULL-terminator is lost. This causes issues when one
> creates device with name "MICROCHIP_AR1021_I2C" as i2c core cuts off the
> last "C", and automatic module loading by alias does not work as result.
> 
> The -I2C suffix in the device name is superfluous, we know what bus we
> are dealing with, so let's drop it.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=116211
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/ar1021_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
> index 71b5a63..89f9587 100644
> --- a/drivers/input/touchscreen/ar1021_i2c.c
> +++ b/drivers/input/touchscreen/ar1021_i2c.c
> @@ -152,7 +152,7 @@ static int __maybe_unused ar1021_i2c_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(ar1021_i2c_pm, ar1021_i2c_suspend, ar1021_i2c_resume);
>  
>  static const struct i2c_device_id ar1021_i2c_id[] = {
> -	{ "MICROCHIP_AR1021_I2C", 0 },
> +	{ "MICROCHIP_AR1021", 0 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, ar1021_i2c_id);

For consistency with the rest of the universe, the name should simply be
"ar1021". No other driver uses capitals, and the manufacturer name is
normally not included, except in very rare cases of incompatible name
collisions.

Thanks,
-- 
Jean Delvare
SUSE L3 Support

