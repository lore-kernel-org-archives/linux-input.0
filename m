From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: atmel_mxt_ts - add touchpad button mapping for
 Samsung Chromebook 3
Date: Tue, 29 May 2018 11:36:11 -0700
Message-ID: <20180529183611.GD167092@dtor-ws>
References: <20180528195045.21036-1-sultanxda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180528195045.21036-1-sultanxda@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Sultan Alsawaf <sultanxda@gmail.com>
Cc: nick@shmanahar.org, linux-input@vger.kernel.org, bleung@chromium.org, stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

Hi Sultan,

On Mon, May 28, 2018 at 12:50:45PM -0700, Sultan Alsawaf wrote:
> This patch adds the correct platform data information for the Celes
> Chromebook, so that the mouse button does not get stuck in pressed state
> after the first click.
> 
> The Samus button keymap and platform data definition are the correct
> ones for Celes, so they have been reused here.

There is quite a reshuffle going on between chromeos-laptop.c and
atmel_mxt_ts at the moment, and your patch does not apply. I think the
best way forward would be:

- get this patch into stable train as is
- I'll prepare a new patch that makes necessary changes in
  chromeos-laptop.c for the upcoming merge window.

That means that 4.17 will not have the fix, but the first stable release
of 4.17.x should have it.

I'm cc-ing a few people.

> 
> Signed-off-by: Sultan Alsawaf <sultanxda@gmail.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 429b694405c7..0c022f4c1a19 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -3039,6 +3039,15 @@ static const struct dmi_system_id mxt_dmi_table[] = {
>  		},
>  		.driver_data = samus_platform_data,
>  	},
> +	{
> +		/* Samsung Chromebook 3 (Celes) */
> +		.ident = "Samsung Chromebook 3 (Celes)",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Celes"),
> +		},
> +		.driver_data = samus_platform_data,
> +	},
>  	{
>  		/* Other Google Chromebooks */
>  		.ident = "Chromebook",
> -- 
> 2.17.0
> 

Thanks.

-- 
Dmitry
