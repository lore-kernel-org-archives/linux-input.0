From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/5] input: touchscreen: add imx6ul_tsc driver support
Date: Sat, 5 Sep 2015 11:53:08 -0700
Message-ID: <20150905185308.GC18006@dtor-ws>
References: <1440752976-9094-1-git-send-email-haibo.chen@freescale.com>
 <1440752976-9094-2-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1440752976-9094-2-git-send-email-haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Aug 28, 2015 at 05:09:32PM +0800, Haibo Chen wrote:
> Freescale i.MX6UL contains a internal touchscreen controller,
> this patch add a driver to support this controller.
> 
> Signed-off-by: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Merged #1 and #2 and applied, thank you.

Also:

> +		/*
> +		 * Delay some time(max 2ms), wait the pre-charge done.
> +		 * After the pre-change mode, TSC go into detect mode.
> +		 * And in detect mode, we can get the xnur gpio value.
> +		 * If xnur is high, this means the touch screen still
> +		 * be touched. If xnur is low, this means finger leave
> +		 * the touch screen.
> +		 */
> +		timeout = jiffies + HZ/500;

I do not think that would quite work with HZ < 500. I changed this to

		timeout = jiffies + msecs_to_jiffies(2);

and also moved this block into a separate function.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
