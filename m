From: "Hn Chen" <hn.chen@weidahitech.com>
Subject: RE: [PATCH] Input: wdt87xx_i2c - Add a prodcut_id attribute in sysfs
Date: Fri, 10 Jul 2015 22:18:01 +0800
Message-ID: <1A63A1423E772B419A9D2E882CBCF6C4020A4936@mail>
References: <1436454043-15093-1-git-send-email-hn.chen@weidahitech.com> <20150709180603.GB1237@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:2646 "EHLO
	ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932621AbbGJOSr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jul 2015 10:18:47 -0400
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, charliemooney@google.com

Hi, Dmitry,

Thanks for your question!

Since the controller will change the working freq when the system encounter the power noises, 
like display patterns or on/off, the environment radiation, and charger noises, etc.
The i2c bus will have data error(rarely) randomly cause by the freq change in the old version fw.
We found this issue and fix it in the latest version just one month ago.
The fw guy worry about this issue will have the chance to make the update failed in old version and 
would like to increase the retry number to secure the update process. 
But, yes, you are right, 3 or 10 for the probability are just taking different level risk.
I will roll back it to 3.

Beside the retry number, I will modify the sleep time to 2500ms in sw_reset. 
The origin value is 200ms, it includes the loading fw & boot up to the main function.
The main function will do algorithm initialize and touch calibration about 1.1 second.
The touch calibration will scan the best working freq and it also has high risk when doing fw update.
It is our mistake for not take the touch calibration into the consideration.

And again, thanks for your help!

BR,
Hn.chen

-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
Sent: Friday, July 10, 2015 2:06 AM
To: Hn Chen
Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; charliemooney@google.com
Subject: Re: [PATCH] Input: wdt87xx_i2c - Add a prodcut_id attribute in sysfs

Hi Hn,

On Thu, Jul 09, 2015 at 11:00:43PM +0800, HungNien Chen wrote:
> Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
> ---
>  drivers/input/touchscreen/wdt87xx_i2c.c | 68 
> ++++++++++++++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c 
> b/drivers/input/touchscreen/wdt87xx_i2c.c
> index fb92ae1..b97cb4f 100644
> --- a/drivers/input/touchscreen/wdt87xx_i2c.c
> +++ b/drivers/input/touchscreen/wdt87xx_i2c.c
> @@ -23,7 +23,7 @@
>  #include <asm/unaligned.h>
>  
>  #define WDT87XX_NAME		"wdt87xx_i2c"
> -#define WDT87XX_DRV_VER		"0.9.6"
> +#define WDT87XX_DRV_VER		"0.9.7"
>  #define WDT87XX_FW_NAME		"wdt87xx_fw.bin"
>  #define WDT87XX_CFG_NAME	"wdt87xx_cfg.bin"
>  
> @@ -39,7 +39,7 @@
>  #define WDT_FIRMWARE_ID			0xa9e368f5
>  
>  #define PG_SIZE				0x1000
> -#define MAX_RETRIES			3
> +#define MAX_RETRIES			10

I need to understand better why we need to increase number of retries.
Why would writing firmware/config page fail? We already retry 3 times (which I am not too happy about) and now we need to try 10 times? It seems we are trying to paper over a bigger problem.

>  
>  #define MAX_UNIT_AXIS			0x7FFF
>  
> @@ -85,6 +85,11 @@
>  #define CTL_PARAM_OFFSET_PHY_H		24
>  #define CTL_PARAM_OFFSET_FACTOR		32
>  
> +/* The definition of the device descriptor */
> +#define	GD_DEVICE			1
> +#define	DEV_DESC_OFFSET_VID		8
> +#define	DEV_DESC_OFFSET_PID		10
> +
>  /* Communication commands */
>  #define PACKET_SIZE			56
>  #define VND_REQ_READ			0x06
> @@ -165,6 +170,8 @@ struct wdt87xx_sys_param {
>  	u16	scaling_factor;
>  	u32	max_x;
>  	u32	max_y;
> +	u16	vendor_id;
> +	u16	product_id;

The vendor and product id of the device usually go into input dveice:

	input->id.vendor
	input->id.product

the custom attributes should be created for data that is not covered by the standard attributes (like you have with config_csum or fw_version).

Thanks.

--
Dmitry
