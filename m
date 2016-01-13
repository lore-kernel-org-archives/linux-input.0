From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 1/2] input: gpio-keys: add support for disable button
 from DT
Date: Tue, 12 Jan 2016 23:06:09 -0800
Message-ID: <20160113070609.GB8906@dtor-ws>
References: <1452665657-9412-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1452665657-9412-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 13, 2016 at 11:44:16AM +0530, Laxman Dewangan wrote:
> Add support to disable the button from DT via status property
> if given button is not supporting on given platforms.
> 
> This will help to re-use the existing dtsi file with status
> enable/disable across platforms.
> 
> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> Changes from V1:
> - Converted print to dev_dbg.
> 
>  drivers/input/keyboard/gpio_keys.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index bef317f..08bada8 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -632,6 +632,14 @@ gpio_keys_get_devtree_pdata(struct device *dev)
>  	for_each_child_of_node(node, pp) {

>  		enum of_gpio_flags flags;
>  
> +		/* Ignore the button if status of node is disabled */
> +		error = of_device_is_available(pp);
> +		if (!error) {
> +			dev_dbg(dev, "Button %s is ignored\n", pp->name);
> +			pdata->nbuttons--;

Looking at this some more, maybe we should be using
of_get_available_child_count() when calculating pdata->nbuttons (and do
not decrement it here) and maybe even use
for_each_available_child_of_node() in this loop and forego manual check.

> +			continue;
> +		}
> +
>  		button = &pdata->buttons[i++];
>  
>  		button->gpio = of_get_gpio_flags(pp, 0, &flags);
> -- 
> 2.1.4
> 

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
