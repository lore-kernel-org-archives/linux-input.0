From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [v1.1 2/3] fix reset gpio config error
Date: Thu, 7 Jul 2016 10:03:09 -0700
Message-ID: <20160707170309.GH5447@dtor-ws>
References: <1467909540-43525-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:32874 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbcGGRDP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2016 13:03:15 -0400
Content-Disposition: inline
In-Reply-To: <1467909540-43525-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jeffrey.lin" <yajohn@gmail.com>
Cc: rydberg@euromail.se, groeck@chromium.org, robh@kernel.org, jeffrey.lin@rad-ic.com, ealin.chiu@rad-ic.com, jason.yeh@rad-ic.com, KP.li@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Jul 07, 2016 at 09:39:00AM -0700, jeffrey.lin wrote:
> ts->reset_gpio=0 will let raydium IC enter reset mode, and ts->reset_gpio=1 will be normal touch mode.
> 
> Signed-off-by: jeffrey.lin <jeffrey.lin@rad-ic.com>

As I mentioned in the original review, this is wrong. gpiod APIs take
into account the declared polarity of a given line, so 1 always means
"active" and 0 means "inactive", even for "active low" pins.

> ---
>  drivers/input/touchscreen/raydium_i2c_ts.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
> index f3076d9..5217339 100644
> --- a/drivers/input/touchscreen/raydium_i2c_ts.c
> +++ b/drivers/input/touchscreen/raydium_i2c_ts.c
> @@ -78,7 +78,7 @@
>  #define RM_MAX_FW_RETRIES	30
>  #define RM_MAX_FW_SIZE		0xD000
>  
> -#define RM_POWERON_DELAY_USEC	500
> +#define RM_POWERON_DELAY_MSEC	20

Why do we need to increase this delay?

>  #define RM_RESET_DELAY_MSEC	50
>  
>  enum raydium_bl_cmd {
> @@ -933,7 +933,7 @@ static int raydium_i2c_power_on(struct raydium_data *ts)
>  	if (!ts->reset_gpio)
>  		return 0;
>  
> -	gpiod_set_value_cansleep(ts->reset_gpio, 1);
> +	gpiod_set_value_cansleep(ts->reset_gpio, 0);
>  
>  	error = regulator_enable(ts->avdd);
>  	if (error) {
> @@ -950,10 +950,10 @@ static int raydium_i2c_power_on(struct raydium_data *ts)
>  		goto release_reset_gpio;
>  	}
>  
> -	udelay(RM_POWERON_DELAY_USEC);
> +	msleep(RM_POWERON_DELAY_MSEC);
>  
>  release_reset_gpio:
> -	gpiod_set_value_cansleep(ts->reset_gpio, 0);
> +	gpiod_set_value_cansleep(ts->reset_gpio, 1);
>  
>  	if (error)
>  		return error;
> @@ -968,7 +968,6 @@ static void raydium_i2c_power_off(void *_data)
>  	struct raydium_data *ts = _data;
>  
>  	if (ts->reset_gpio) {
> -		gpiod_set_value_cansleep(ts->reset_gpio, 1);
>  		regulator_disable(ts->vccio);
>  		regulator_disable(ts->avdd);
>  	}
> -- 
> 2.1.2
> 

Thanks.

-- 
Dmitry
