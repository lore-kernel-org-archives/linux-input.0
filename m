From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: goodix - Fix touch coords on WinBook TW100 and
 TW700
Date: Thu, 23 Jul 2015 14:56:37 -0700
Message-ID: <20150723215637.GF12733@dtor-ws>
References: <1437660808.2863.9.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36039 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177AbbGWV4m (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 17:56:42 -0400
Content-Disposition: inline
In-Reply-To: <1437660808.2863.9.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bastien,

On Thu, Jul 23, 2015 at 04:13:28PM +0200, Bastien Nocera wrote:
> The touchscreen on the WinBook TW100 and TW700 don't match the default
> display, with 0,0 touches being reported when touching at the bottom
> right of the screen.
> 
>   1280,800             0,800
>          +-------------+
>          |             |
>          |             |
>          |             |
>          +-------------+
>     1280,0             0,0
> 
> It's unfortunately impossible to detect this problem with data from the
> DSDT, or other auxiliary metadata, so fallback to quirking this specific
> model of tablet instead.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/input/touchscreen/goodix.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index b4d12e2..3722806 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -15,6 +15,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/dmi.h>
>  #include <linux/i2c.h>
>  #include <linux/input.h>
>  #include <linux/input/mt.h>
> @@ -34,6 +35,7 @@ struct goodix_ts_data {
>  	int abs_y_max;
>  	unsigned int max_touch_num;
>  	unsigned int int_trigger_type;
> +	bool rotated_screen;
>  };
>  
>  #define GOODIX_MAX_HEIGHT		4096
> @@ -60,6 +62,24 @@ static const unsigned long goodix_irq_flags[] = {
>  	IRQ_TYPE_LEVEL_HIGH,
>  };
>  
> +/* Those tablets have their coords origin at the bottom right
> + * of the tablet, as if rotated 180 degrees */

/*
 * Multi
 * line
 * comment
 */

please.

> +static const struct dmi_system_id rotated_screen[] = {

#if defined(CONFIG_DMI) && defined(CONFIG_X86)

> +	{
> +		.ident = "WinBook TW100",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "WinBook"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "TW100")
> +		},
> +		.ident = "WinBook TW700",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "WinBook"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "TW100")
> +		},

This does not do what you want it to do... First of all you probably
wanted TW700 on the second entry, second you need separate them into 2
entries into array (right now it is one still).

Thank you.

-- 
Dmitry
