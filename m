From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: cros_ec_keyb: Add Tablet Mode switch.
Date: Wed, 1 Feb 2017 09:54:17 -0800
Message-ID: <20170201175417.GA40720@dtor-ws>
References: <20170127105235.4727-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170127105235.4727-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
List-Id: linux-input@vger.kernel.org

On Fri, Jan 27, 2017 at 11:52:35AM +0100, Enric Balletbo i Serra wrote:
> From: Gwendal Grignou <gwendal@chromium.org>
> 
> Add switch to report tablet mode.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Enric Balletbo Serra <enric.balletbo@collabora.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Lee, can you please take it as well?

> ---
> 
> I should be included this patch in the following patch series but I missed the
> patch and found later. Though it can be applied separetely.
> 
>  - [PATCH 1/2] mfd: cros-ec: Update cros_ec_commands.h for buttons and switches
>  - [PATCH 2/2] input: cros_ec_keyb: Add non-matrix buttons and switches
> 
>  drivers/input/keyboard/cros_ec_keyb.c | 5 +++++
>  include/linux/mfd/cros_ec_commands.h  | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index ad74ebc..604c7ad 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -111,6 +111,11 @@ static const struct cros_ec_bs_map cros_ec_keyb_bs[] = {
>  		.bit		= EC_MKBP_LID_OPEN,
>  		.inverted	= true,
>  	},
> +	{
> +		.ev_type	= EV_SW,
> +		.code		= SW_TABLET_MODE,
> +		.bit		= EC_MKBP_TABLET_MODE,
> +	},
>  };
>  
>  /*
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index a01dde4..e793e9f 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -2094,6 +2094,7 @@ struct ec_response_get_next_event {
>  
>  /* Switches */
>  #define EC_MKBP_LID_OPEN	0
> +#define EC_MKBP_TABLET_MODE	1
>  
>  /*****************************************************************************/
>  /* Temperature sensor commands */
> -- 
> 2.9.3
> 

-- 
Dmitry
