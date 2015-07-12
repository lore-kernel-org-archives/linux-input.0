From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wdt87xx_i2c - Change the sleep time to 2500ms
 after the sw reset
Date: Sat, 11 Jul 2015 23:28:47 -0700
Message-ID: <20150712062847.GA37026@dtor-ws>
References: <1436625402-4501-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33407 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbGLG2x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jul 2015 02:28:53 -0400
Content-Disposition: inline
In-Reply-To: <1436625402-4501-1-git-send-email-hn.chen@weidahitech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: HungNien Chen <hn.chen@weidahitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, charliemooney@google.com

On Sat, Jul 11, 2015 at 10:36:42PM +0800, HungNien Chen wrote:
>  The original value is 200ms, it includes the loading fw & boot up to
>  the main function. After that, the main function will do algorithm
>  initialized and touch calibrtion about 1.1 second. The touch
>  calibration will change controller freq to scan the best working freq 
>  and it has risk to make the i2c data error when doing fw update. 
>  We extend the sleep to 2500ms after the sw reset to skip this period time.
> 
> Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/wdt87xx_i2c.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
> index b97cb4f..cfd1487 100644
> --- a/drivers/input/touchscreen/wdt87xx_i2c.c
> +++ b/drivers/input/touchscreen/wdt87xx_i2c.c
> @@ -157,6 +157,7 @@
>  /* Controller requires minimum 300us between commands */
>  #define WDT_COMMAND_DELAY_MS		2
>  #define WDT_FLASH_WRITE_DELAY_MS	4
> +#define	WDT_FW_RESET_TIME		2500
>  
>  struct wdt87xx_sys_param {
>  	u16	fw_id;
> @@ -413,7 +414,7 @@ static int wdt87xx_sw_reset(struct i2c_client *client)
>  	}
>  
>  	/* Wait the device to be ready */
> -	msleep(200);
> +	msleep(WDT_FW_RESET_TIME);
>  
>  	return 0;
>  }
> -- 
> 1.9.1
> 

-- 
Dmitry
