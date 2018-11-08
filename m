From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] input: cros_ec_keyb: fix button/switch capability reports
Date: Thu, 08 Nov 2018 09:55:14 +0100
Message-ID: <3546338.6jxQVHVFiU@phil>
References: <20181107223813.178462-1-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107223813.178462-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.co.uk>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Doug Anderson <dianders@chromium.org>
List-Id: linux-input@vger.kernel.org

Am Mittwoch, 7. November 2018, 23:38:13 CET schrieb Brian Norris:
> The cros_ec_keyb_bs array lists buttons and switches together, expecting
> that its users will match the appropriate type and bit fields. But
> cros_ec_keyb_register_bs() only checks the 'bit' field, which causes
> misreported input capabilities in some cases. For example, tablets
> (e.g., Scarlet -- a.k.a. Acer Chromebook Tab 10) were reporting a SW_LID
> capability, because EC_MKBP_POWER_BUTTON and EC_MKBP_LID_OPEN happen to
> share the same bit.
> 
> (This has comedic effect on a tablet, in which a power-management daemon
> then thinks this "lid" is closed, and so puts the system to sleep as
> soon as it boots!)
> 
> To fix this, check both the 'ev_type' and 'bit' fields before reporting
> the capability.
> 
> Tested with a lid (Kevin / Samsung Chromebook Plus) and without a lid
> (Scarlet / Acer Chromebook Tab 10).
> 
> This error got introduced when porting the feature from the downstream
> Chromium OS kernel to be upstreamed.
> 
> Fixes: cdd7950e7aa4 ("input: cros_ec_keyb: Add non-matrix buttons and switches")
> Cc: <stable@vger.kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


> ---
>  drivers/input/keyboard/cros_ec_keyb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 81be6f781f0b..d56001181598 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -493,7 +493,8 @@ static int cros_ec_keyb_register_bs(struct cros_ec_keyb *ckdev)
>  	for (i = 0; i < ARRAY_SIZE(cros_ec_keyb_bs); i++) {
>  		const struct cros_ec_bs_map *map = &cros_ec_keyb_bs[i];
>  
> -		if (buttons & BIT(map->bit))
> +		if ((map->ev_type == EV_KEY && (buttons & BIT(map->bit))) ||
> +		    (map->ev_type == EV_SW && (switches & BIT(map->bit))))
>  			input_set_capability(idev, map->ev_type, map->code);
>  	}
>  
> 
