From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wdt87xx_i2c - Add a prodcut_id attribute in sysfs
Date: Thu, 9 Jul 2015 11:06:03 -0700
Message-ID: <20150709180603.GB1237@dtor-ws>
References: <1436454043-15093-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33203 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbbGISGI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2015 14:06:08 -0400
Content-Disposition: inline
In-Reply-To: <1436454043-15093-1-git-send-email-hn.chen@weidahitech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: HungNien Chen <hn.chen@weidahitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, charliemooney@google.com

Hi Hn,

On Thu, Jul 09, 2015 at 11:00:43PM +0800, HungNien Chen wrote:
> Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
> ---
>  drivers/input/touchscreen/wdt87xx_i2c.c | 68 ++++++++++++++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
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
Why would writing firmware/config page fail? We already retry 3 times
(which I am not too happy about) and now we need to try 10 times? It
seems we are trying to paper over a bigger problem.

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

the custom attributes should be created for data that is not covered by
the standard attributes (like you have with config_csum or fw_version).

Thanks.

-- 
Dmitry
