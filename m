From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Tue, 16 Aug 2016 13:47:06 +0100
Message-ID: <20160816124706.GJ25844@dell>
References: <cover.1470316956.git.ksenija.stanojevic@gmail.com>
 <0a60a10b249062d305237f04fdb9aea05b128b85.1470316956.git.ksenija.stanojevic@gmail.com>
 <2721285.1CS7CJCgc7@ws-stein>
 <20160805070224.GH5243@dell>
 <22e16c7d-4ad7-6432-11e7-30b6b6194573@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <22e16c7d-4ad7-6432-11e7-30b6b6194573-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org, stefan.wahren-eS4NqCHxEME@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 15 Aug 2016, Jonathan Cameron wrote:

> On 05/08/16 08:02, Lee Jones wrote:
> > On Thu, 04 Aug 2016, Alexander Stein wrote:
> > 
> >> On Thursday 04 August 2016 15:28:18, Ksenija Stanojevic wrote:
> >>> Add core files for mxs-lradc MFD driver.
> >>>
> >>> Note:  this patch won't compile in iio/testing without this patch:
> >>> a8f447be8056 ("mfd: Add resource managed APIs for mfd_add_devices")
> >>>
> >>> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>> ---
> >>> [...]
> >>> +static int mxs_lradc_probe(struct platform_device *pdev)
> >>> +{
> >>> +	const struct of_device_id *of_id;
> >>> +	struct device *dev = &pdev->dev;
> >>> +	struct device_node *node = dev->of_node;
> >>> +	struct mxs_lradc *lradc;
> >>> +	struct resource *iores;
> >>> +	struct mfd_cell *cells = NULL;
> >>> +	int ret = 0;
> >>> +	u32 ts_wires = 0;
> >>> +
> >>> +	lradc = devm_kzalloc(&pdev->dev, sizeof(*lradc), GFP_KERNEL);
> >>> +	if (!lradc)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	of_id = of_match_device(mxs_lradc_dt_ids, &pdev->dev);
> >>> +	lradc->soc = (enum mxs_lradc_id)of_id->data;
> >>> +
> >>> +	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>> +	lradc->base = devm_ioremap_resource(dev, iores);
> >>
> >> Out of couriosity: Is it common to pass already ioremapped addresses to (MFD 
> >> cell) platform drivers? I would have expected, and done myself, that ioremap 
> >> is done in the driver itself, same as the IRQ.
> > 
> > Yes, this is exactly what should happen.
> > 
> Lee, you've confused me with this answer.  Yes, it is common or Yes it
> should have been done the way Alexander suggested?

The remapping and IRQ obtainment should be done in the leaf driver.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
