From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2] Input: ar1021-i2c - fix too long name in driver's
 device table
Date: Sat, 15 Apr 2017 08:42:29 +0200
Message-ID: <20170415084229.397168d4@endymion>
References: <20170413233225.GA30465@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33662 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752028AbdDOGmd (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 15 Apr 2017 02:42:33 -0400
In-Reply-To: <20170413233225.GA30465@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, m.frohiky@gmail.com, Christian Gmeiner <christian.gmeiner@gmail.com>, linux-kernel@vger.kernel.org

On Thu, 13 Apr 2017 16:32:25 -0700, Dmitry Torokhov wrote:
> The name field in structure i2c_device_id is 20 characters, and we expect
> it to be NULL-terminated, however we are trying to stuff it with 21 bytes
> and thus NULL-terminator is lost. This causes issues when one creates
> device with name "MICROCHIP_AR1021_I2C" as i2c core cuts off the last "C",
> and automatic module loading by alias does not work as result.
> 
> The -I2C suffix in the device name is superfluous, we know what bus we are
> dealing with, so let's drop it. Also, no other driver uses capitals, and
> the manufacturer name is normally not included, except in very rare cases
> of incompatible name collisions.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=116211
> Fixes: dd4cae8bf166 ("Input: Add Microchip AR1021 i2c touchscreen")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> V2: Changed MICROCHIP_AR1021 -> ar1021 as Jean suggested.
> 
>  drivers/input/touchscreen/ar1021_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

> diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
> index 2e7500edd477..6797e123925a 100644
> --- a/drivers/input/touchscreen/ar1021_i2c.c
> +++ b/drivers/input/touchscreen/ar1021_i2c.c
> @@ -151,7 +151,7 @@ static int __maybe_unused ar1021_i2c_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(ar1021_i2c_pm, ar1021_i2c_suspend, ar1021_i2c_resume);
>  
>  static const struct i2c_device_id ar1021_i2c_id[] = {
> -	{ "MICROCHIP_AR1021_I2C", 0 },
> +	{ "ar1021", 0 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, ar1021_i2c_id);


-- 
Jean Delvare
SUSE L3 Support
