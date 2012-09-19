From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/5] MFD: ti_tscadc: Add support for TI's TSC/ADC MFDevice
Date: Wed, 19 Sep 2012 17:30:05 +0200
Message-ID: <20120919153005.GG28670@sortiz-mobl>
References: <1345718997-18304-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1345718997-18304-1-git-send-email-rachna-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Rachna

A couple of comments:

On Thu, Aug 23, 2012 at 04:19:57PM +0530, Patil, Rachna wrote:
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index d1facef..81eb815 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -94,6 +94,15 @@ config MFD_TI_SSP
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ti-ssp.
>  
> +config MFD_TI_TSCADC
> +	tristate "TI ADC / Touch Screen chip support"
> +	depends on ARCH_OMAP2PLUS
What makes it OMAP2PLUS or even ARCH specific at all ?


> +static unsigned int tscadc_readl(struct ti_tscadc_dev *tsadc, unsigned int reg)
> +{
> +	return readl(tsadc->tscadc_base + reg);
> +}
> +
> +static void tscadc_writel(struct ti_tscadc_dev *tsadc, unsigned int reg,
> +					unsigned int val)
> +{
> +	writel(val, tsadc->tscadc_base + reg);
> +}
Please use regmap MMIO for that stuff. It won't make the code shorter, but
more robust.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
