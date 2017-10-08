From: Nick Dyer <nick@shmanahar.org>
Subject: Re: [PATCH] input: atmel_mxt_ts: detect touchpad from devicetree
Date: Sun, 8 Oct 2017 20:56:01 +0100
Message-ID: <20171008195601.GC29090@lava.h.shmanahar.org>
References: <20171004193531.9038-1-kernel@esmil.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout07.plus.net ([84.93.230.235]:40897 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753715AbdJHT4D (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 8 Oct 2017 15:56:03 -0400
Content-Disposition: inline
In-Reply-To: <20171004193531.9038-1-kernel@esmil.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Emil Renner Berthing <kernel@esmil.dk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Oct 04, 2017 at 09:35:31PM +0200, Emil Renner Berthing wrote:
> The Samsung Chromebook Plus (rk3399-gru-kevin) has two of
> these controllers. One for the touchscreen and one for
> the touchpad. However the touchpad doesn't have any
> associated gpio buttons, so it shows up as another
> touchscreen.
> 
> This patch fixes it by matching the "atmel,atmel_mxt_tp"
> compatibility string in the device tree.

Thanks. I think this makes sense, given there are already devices out
there using "atmel_mxt_tp".

Is the hardcoded MXT_PIXELS_PER_MM going to cause issues on this new
device?

I think you need to add this to
Documentation/devicetree/bindings/input/atmel,maxtouch.txt

Reviewed-by: Nick Dyer <nick@shmanahar.org>

> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c   | 8 ++++++--
>  include/linux/platform_data/atmel_mxt_ts.h | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 7659bc48f1db..4ea06f447d15 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -1945,8 +1945,7 @@ static int mxt_initialize_input_device(struct mxt_data *data)
>  		input_set_abs_params(input_dev, ABS_PRESSURE, 0, 255, 0, 0);
>  	}
>  
> -	/* If device has buttons we assume it is a touchpad */
> -	if (pdata->t19_num_keys) {
> +	if (pdata->touchpad) {
>  		mxt_set_up_as_touchpad(input_dev, data);
>  		mt_flags |= INPUT_MT_POINTER;
>  	} else {
> @@ -2936,6 +2935,9 @@ static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
>  	if (!pdata)
>  		return ERR_PTR(-ENOMEM);
>  
> +	if (of_device_is_compatible(np, "atmel,atmel_mxt_tp"))
> +		pdata->touchpad = true;
> +
>  	if (of_find_property(np, "linux,gpio-keymap", &proplen)) {
>  		pdata->t19_num_keys = proplen / sizeof(u32);
>  
> @@ -2986,6 +2988,7 @@ static struct mxt_acpi_platform_data samus_platform_data[] = {
>  		.pdata	= {
>  			.t19_num_keys	= ARRAY_SIZE(samus_touchpad_buttons),
>  			.t19_keymap	= samus_touchpad_buttons,
> +			.touchpad	= true,
>  		},
>  	},
>  	{
> @@ -3011,6 +3014,7 @@ static struct mxt_acpi_platform_data chromebook_platform_data[] = {
>  		.pdata	= {
>  			.t19_num_keys	= ARRAY_SIZE(chromebook_tp_buttons),
>  			.t19_keymap	= chromebook_tp_buttons,
> +			.touchpad	= true,
>  		},
>  	},
>  	{
> diff --git a/include/linux/platform_data/atmel_mxt_ts.h b/include/linux/platform_data/atmel_mxt_ts.h
> index 695035a8d7fb..acb595bba02d 100644
> --- a/include/linux/platform_data/atmel_mxt_ts.h
> +++ b/include/linux/platform_data/atmel_mxt_ts.h
> @@ -24,6 +24,7 @@ enum mxt_suspend_mode {
>  struct mxt_platform_data {
>  	unsigned long irqflags;
>  	u8 t19_num_keys;
> +	u8 touchpad;
>  	const unsigned int *t19_keymap;
>  	enum mxt_suspend_mode suspend_mode;
>  };
> -- 
> 2.14.2
> 
