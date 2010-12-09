From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2]input - wacom_w8001: Support pen or touch only devices
Date: Wed, 8 Dec 2010 22:42:22 -0800
Message-ID: <20101209064222.GA6233@core.coreip.homeip.net>
References: <1291857433-13731-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:49730 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849Ab0LIGm3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2010 01:42:29 -0500
Received: by gwb20 with SMTP id 20so1737109gwb.1
        for <linux-input@vger.kernel.org>; Wed, 08 Dec 2010 22:42:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291857433-13731-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Hi Ping,

On Wed, Dec 08, 2010 at 05:17:13PM -0800, Ping Cheng wrote:
> Not all penabled devices support touch. The same idea is true for
> touch devices. Setting up the devices according to the specific
> querying results.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
>  drivers/input/touchscreen/wacom_w8001.c |   39 ++++++++++++++++++++++++------
>  1 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
> index 361d00a..90b92e8 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -37,6 +37,7 @@ MODULE_LICENSE("GPL");
>  
>  #define W8001_QUERY_PACKET	0x20
>  
> +#define W8001_CMD_STOP		'0'
>  #define W8001_CMD_START		'1'
>  #define W8001_CMD_QUERY		'*'
>  #define W8001_CMD_TOUCHQUERY	'%'
> @@ -279,24 +280,46 @@ static int w8001_setup(struct w8001 *w8001)
>  	struct w8001_coord coord;
>  	int error;
>  
> -	error = w8001_command(w8001, W8001_CMD_QUERY, true);
> +	error = w8001_command(w8001, W8001_CMD_STOP, false);

Isn't there any response from the device to W8001_CMD_STOP?

>  	if (error)
>  		return error;
>  
> -	parse_data(w8001->response, &coord);
> +	mdelay(250);	/* wait 250ms before querying the device */
>  
> -	input_set_abs_params(dev, ABS_X, 0, coord.x, 0, 0);
> -	input_set_abs_params(dev, ABS_Y, 0, coord.y, 0, 0);
> -	input_set_abs_params(dev, ABS_PRESSURE, 0, coord.pen_pressure, 0, 0);
> -	input_set_abs_params(dev, ABS_TILT_X, 0, coord.tilt_x, 0, 0);
> -	input_set_abs_params(dev, ABS_TILT_Y, 0, coord.tilt_y, 0, 0);
> +	/* penabled? */
> +	error = w8001_command(w8001, W8001_CMD_QUERY, true);
> +	if (!error) {
> +		dev->keybit[BIT_WORD(BTN_TOOL_PEN)] |= BIT_MASK(BTN_TOOL_PEN);
> +		dev->keybit[BIT_WORD(BTN_TOOL_RUBBER)] |= BIT_MASK(BTN_TOOL_RUBBER);
> +		dev->keybit[BIT_WORD(BTN_STYLUS)] |= BIT_MASK(BTN_STYLUS);
> +		dev->keybit[BIT_WORD(BTN_STYLUS2)] |= BIT_MASK(BTN_STYLUS2);

Could we start switching to __set_bit(BTN_TOOL_PEN, dev->keybit) style?
The original way was somewhat OK when setting several buttons at once
but I feel __set_bit() form is much safer.

> +		parse_data(w8001->response, &coord);
> +
> +		input_set_abs_params(dev, ABS_X, 0, coord.x, 0, 0);
> +		input_set_abs_params(dev, ABS_Y, 0, coord.y, 0, 0);
> +		input_set_abs_params(dev, ABS_PRESSURE, 0, coord.pen_pressure, 0, 0);
> +		if (coord.tilt_x && coord.tilt_y)
> +		{

Formatting: opening brace goes on the same as the statement.

> +			input_set_abs_params(dev, ABS_TILT_X, 0, coord.tilt_x, 0, 0);
> +			input_set_abs_params(dev, ABS_TILT_Y, 0, coord.tilt_y, 0, 0);
> +		}
> +	}
>  
> +	/* touch enabled? */
>  	error = w8001_command(w8001, W8001_CMD_TOUCHQUERY, true);
> -	if (!error) {
> +
> +	/* Some non-touch devices may reply to the touch query. But their
> +	 * second byte is empty, which indicates touch is not supported.
> +	 */
> +	if (!error && w8001->response[1]) {
>  		struct w8001_touch_query touch;
>  
>  		parse_touchquery(w8001->response, &touch);
>  
> +		input_set_abs_params(dev, ABS_X, 0, touch.x, 0, 0);
> +		input_set_abs_params(dev, ABS_Y, 0, touch.y, 0, 0);
> +		dev->keybit[BIT_WORD(BTN_TOOL_FINGER)] |= BIT_MASK(BTN_TOOL_FINGER);
> +
>  		switch (touch.sensor_id) {
>  		case 0:
>  		case 2:
> -- 
> 1.7.2.3
> 

Thanks.

-- 
Dmitry
