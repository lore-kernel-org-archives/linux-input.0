From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: sun4i-lradc: Convert to using %pOFn instead of
 device_node.name
Date: Fri, 28 Sep 2018 16:59:16 -0700
Message-ID: <20180928235916.GA182370@dtor-ws>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-23-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180828015252.28511-23-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@bootlin.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Aug 27, 2018 at 08:52:24PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thank you.

> ---
>  drivers/input/keyboard/sun4i-lradc-keys.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
> index a37c172452e6..57272df34cd5 100644
> --- a/drivers/input/keyboard/sun4i-lradc-keys.c
> +++ b/drivers/input/keyboard/sun4i-lradc-keys.c
> @@ -185,19 +185,19 @@ static int sun4i_lradc_load_dt_keymap(struct device *dev,
>  
>  		error = of_property_read_u32(pp, "channel", &channel);
>  		if (error || channel != 0) {
> -			dev_err(dev, "%s: Inval channel prop\n", pp->name);
> +			dev_err(dev, "%pOFn: Inval channel prop\n", pp);
>  			return -EINVAL;
>  		}
>  
>  		error = of_property_read_u32(pp, "voltage", &map->voltage);
>  		if (error) {
> -			dev_err(dev, "%s: Inval voltage prop\n", pp->name);
> +			dev_err(dev, "%pOFn: Inval voltage prop\n", pp);
>  			return -EINVAL;
>  		}
>  
>  		error = of_property_read_u32(pp, "linux,code", &map->keycode);
>  		if (error) {
> -			dev_err(dev, "%s: Inval linux,code prop\n", pp->name);
> +			dev_err(dev, "%pOFn: Inval linux,code prop\n", pp);
>  			return -EINVAL;
>  		}
>  
> -- 
> 2.17.1
> 

-- 
Dmitry
