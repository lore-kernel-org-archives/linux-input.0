From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 1/1] input: gpio-keys: add support for disable button
 from DT
Date: Wed, 13 Jan 2016 00:16:24 -0800
Message-ID: <20160113081624.GA21845@dtor-ws>
References: <1452669980-16460-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1452669980-16460-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 13, 2016 at 12:56:20PM +0530, Laxman Dewangan wrote:
> Add support to disable the button from DT via status property
> if given button is not supporting on given platforms.
> 
> This will help to re-use the existing dtsi file with status
> enable/disable across platforms.
> 
> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Applied, thank you.

> ---
> Changes from V1: 
> - Converted print to dev_dbg.
> Changes from V2:
> - use of_get_available_child_count() and for_each_available_child_of_node()
> 
>  drivers/input/keyboard/gpio_keys.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index bef317f..ef6ca1c 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -613,7 +613,7 @@ gpio_keys_get_devtree_pdata(struct device *dev)
>  	if (!node)
>  		return ERR_PTR(-ENODEV);
>  
> -	nbuttons = of_get_child_count(node);
> +	nbuttons = of_get_available_child_count(node);
>  	if (nbuttons == 0)
>  		return ERR_PTR(-ENODEV);
>  
> @@ -629,7 +629,7 @@ gpio_keys_get_devtree_pdata(struct device *dev)
>  	pdata->rep = !!of_get_property(node, "autorepeat", NULL);
>  
>  	i = 0;
> -	for_each_child_of_node(node, pp) {
> +	for_each_available_child_of_node(node, pp) {
>  		enum of_gpio_flags flags;
>  
>  		button = &pdata->buttons[i++];
> -- 
> 2.1.4
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
