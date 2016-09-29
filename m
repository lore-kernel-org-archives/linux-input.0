From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Thu, 29 Sep 2016 18:15:40 +0100
Message-ID: <20160929171540.GB2844@dell>
References: <cover.1474108510.git.ksenija.stanojevic@gmail.com>
 <b50209289b241995c6fd5e23c7343448857fc301.1474108510.git.ksenija.stanojevic@gmail.com>
 <20160928010533.GQ21388@dell>
 <1882238802.204734.75f5f595-10ac-4107-8738-e75dfde001f1.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1882238802.204734.75f5f595-10ac-4107-8738-e75dfde001f1.open-xchange-7tX72C7vayboQLBSYMtkGA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 29 Sep 2016, Stefan Wahren wrote:
> > Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> hat am 28. September 2016 um 03:05
> > geschrieben:
> > 
> > 
> > On Sat, 17 Sep 2016, Ksenija Stanojevic wrote:
> > 
> > > +
> > > +static int mxs_lradc_probe(struct platform_device *pdev)
> > > +{
> > > +	const struct of_device_id *of_id;
> > > +	struct device *dev = &pdev->dev;
> > > +	struct device_node *node = dev->of_node;
> > > +	struct mxs_lradc *lradc;
> > > +	struct mfd_cell *cells = NULL;
> > > +	int ret = 0;
> > > +	u32 ts_wires = 0;
> > > +
> > > +	lradc = devm_kzalloc(&pdev->dev, sizeof(*lradc), GFP_KERNEL);
> > > +	if (!lradc)
> > > +		return -ENOMEM;
> > > +
> > > +	of_id = of_match_device(mxs_lradc_dt_ids, &pdev->dev);
> > > +	lradc->soc = (enum mxs_lradc_id)of_id->data;
> > > +
> > > +	lradc->clk = devm_clk_get(&pdev->dev, NULL);
> > > +	if (IS_ERR(lradc->clk)) {
> > > +		dev_err(dev, "Failed to get the delay unit clock\n");
> > > +		return PTR_ERR(lradc->clk);
> > > +	}
> > > +
> > > +	ret = clk_prepare_enable(lradc->clk);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to enable the delay unit clock\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
> > 
> > Have you moved the documentation into devicetree/bindings/mfd?
> > 
> 
> i hope it's okay if i answer. The binding has moved to
> devicetree/binding/iio/adc/ [1]
> 
> Should it move completely to mfd or split too?
> 
> I'm asking myself how we keep DT ABI in the latter case.
> 
> [1] -
> http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt

I haven't read into the documentation too to deeply, but it stands to
reason that the bindings which are now being used in MFD should be
documented in the MFD binding document, and the ones which are no longer
used in the IIO driver should be removed.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
