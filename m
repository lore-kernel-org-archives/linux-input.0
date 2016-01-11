From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 3/3] Input: cyttsp - add default init function
Date: Mon, 11 Jan 2016 12:02:47 -0800
Message-ID: <20160111200247.GC22646@dtor-ws>
References: <cover.1452447124.git.oreste.salerno@tomtom.com>
 <01aa2661875444ecc771dfce1f466b6846ac5eea.1452447124.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <01aa2661875444ecc771dfce1f466b6846ac5eea.1452447124.git.oreste.salerno-Jdzig1fPfSTQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oreste Salerno <oreste.salerno-Jdzig1fPfSTQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fery-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, Jan 10, 2016 at 06:36:09PM +0100, Oreste Salerno wrote:
> When using device trees, it's not possible to assign an init()
> function in the platform data.
> In case the init function has not been assigned, attempt to
> perform a hard reset of the chip, using reset gpio defined in the
> platform data / device tree.

Hmm, I do not see any users of cyttsp platform data in mainline, so
let's kill init/exit and just do GPIO toggle for everyone. We might need
to add regulator support as well, but that's when someone will need it.

Thanks.

> 
> Signed-off-by: Oreste Salerno <oreste.salerno-Jdzig1fPfSTQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/input/touchscreen/cyttsp_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
> index 5dc6bf6..baf0fd5 100644
> --- a/drivers/input/touchscreen/cyttsp_core.c
> +++ b/drivers/input/touchscreen/cyttsp_core.c
> @@ -239,6 +239,16 @@ static int cyttsp_set_sysinfo_regs(struct cyttsp *ts)
>  	return retval;
>  }
>  
> +static void cyttsp_hard_reset(struct cyttsp *ts)
> +{
> +	if (ts->pdata->reset_gpio) {
> +		gpiod_set_value_cansleep(ts->pdata->reset_gpio, 1);
> +		msleep(CY_DELAY_DFLT);
> +		gpiod_set_value_cansleep(ts->pdata->reset_gpio, 0);
> +		msleep(CY_DELAY_DFLT);
> +	}
> +}
> +
>  static int cyttsp_soft_reset(struct cyttsp *ts)
>  {
>  	unsigned long timeout;
> @@ -685,6 +695,8 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
>  				error);
>  			goto err_free_mem;
>  		}
> +	} else {
> +		cyttsp_hard_reset(ts);
>  	}
>  
>  	input_dev->name = pdata->name;
> -- 
> 1.9.1
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
