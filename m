From: "Hn Chen" <hn.chen@weidahitech.com>
Subject: RE: [PATCH] Input: wdt87xx_i2c - Change the sleep time to 2500ms after the sw reset
Date: Mon, 13 Jul 2015 19:47:03 +0800
Message-ID: <1A63A1423E772B419A9D2E882CBCF6C4020A4A95@mail>
References: <1436625402-4501-1-git-send-email-hn.chen@weidahitech.com> <20150712062847.GA37026@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:2349 "EHLO
	ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbbGMLrl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 07:47:41 -0400
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, charliemooney@google.com

Hi, Dmitry,

Thanks !

BR,
Hn.chen.

-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
Sent: Sunday, July 12, 2015 2:29 PM
To: Hn Chen
Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; charliemooney@google.com
Subject: Re: [PATCH] Input: wdt87xx_i2c - Change the sleep time to 2500ms after the sw reset

On Sat, Jul 11, 2015 at 10:36:42PM +0800, HungNien Chen wrote:
>  The original value is 200ms, it includes the loading fw & boot up to  
> the main function. After that, the main function will do algorithm  
> initialized and touch calibrtion about 1.1 second. The touch  
> calibration will change controller freq to scan the best working freq  
> and it has risk to make the i2c data error when doing fw update.
>  We extend the sleep to 2500ms after the sw reset to skip this period time.
> 
> Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/wdt87xx_i2c.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c 
> b/drivers/input/touchscreen/wdt87xx_i2c.c
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
