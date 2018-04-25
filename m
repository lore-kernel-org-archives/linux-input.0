From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input/touchscreen: atmel_mxt_ts: Add correct touchpad
 button mapping for the Caroline Chromebook.
Date: Wed, 25 Apr 2018 15:26:50 -0700
Message-ID: <20180425222650.GC200812@dtor-ws>
References: <201804251232.w3PCWweA028076@mail.vittgam.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201804251232.w3PCWweA028076@mail.vittgam.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Vittorio Gambaletta (VittGam)" <linuxbugs@vittgam.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org, nick@shmanahar.org, bleung@chromium.org, Salvatore Bellizzi <lkml@seppia.net>, groeck@chromium.org
List-Id: linux-input@vger.kernel.org

On Wed, Apr 25, 2018 at 02:32:58PM +0200, Vittorio Gambaletta (VittGam) wrote:
> This patch adds the correct platform data information for the Caroline
> Chromebook, so that the mouse button does not get stuck in pressed state
> after the first click.
> 
> The Samus button keymap and platform data definition are the correct
> ones for Caroline, so they have been reused here.
> 
> v2: updated patch offset after 20180409 changes.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
> Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>
> 

Applied, thank you.

> ---
> 
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -3035,6 +3035,15 @@
>  		.driver_data = samus_platform_data,
>  	},
>  	{
> +		/* Samsung Chromebook Pro */
> +		.ident = "Samsung Chromebook Pro",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Caroline"),
> +		},
> +		.driver_data = samus_platform_data,
> +	},
> +	{
>  		/* Other Google Chromebooks */
>  		.ident = "Chromebook",
>  		.matches = {

-- 
Dmitry
