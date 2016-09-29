From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Fri, 30 Sep 2016 00:14:30 +0100
Message-ID: <20160929231430.GB13971@dell>
References: <cover.1474108510.git.ksenija.stanojevic@gmail.com>
 <b50209289b241995c6fd5e23c7343448857fc301.1474108510.git.ksenija.stanojevic@gmail.com>
 <20160928010533.GQ21388@dell>
 <1882238802.204734.75f5f595-10ac-4107-8738-e75dfde001f1.open-xchange@email.1und1.de>
 <20160929171540.GB2844@dell>
 <1269746175.25077.ef1d8693-0ff3-4b50-a424-49eebba23da1.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34339 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934860AbcI2XMT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Sep 2016 19:12:19 -0400
Received: by mail-pf0-f172.google.com with SMTP id u78so8076662pfa.1
        for <linux-input@vger.kernel.org>; Thu, 29 Sep 2016 16:12:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1269746175.25077.ef1d8693-0ff3-4b50-a424-49eebba23da1.open-xchange@email.1und1.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, linux-input@vger.kernel.org, pmeerw@pmeerw.net, jic23@kernel.org, linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de, dmitry.torokhov@gmail.com, harald@ccbib.org, fabio.estevam@freescale.com, linux-iio@vger.kernel.org, marex@denx.de, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org

On Thu, 29 Sep 2016, Stefan Wahren wrote:

> Hi Lee,
> 
> [add Rob and Mark]
> 
> > Lee Jones <lee.jones@linaro.org> hat am 29. September 2016 um 19:15
> > geschrieben:
> > 
> > 
> > On Thu, 29 Sep 2016, Stefan Wahren wrote:
> > > > Lee Jones <lee.jones@linaro.org> hat am 28. September 2016 um 03:05
> > > > geschrieben:
> > > > 
> > > > 
> > > > On Sat, 17 Sep 2016, Ksenija Stanojevic wrote:
> > > > 
> > > > > +
> > > > > +static int mxs_lradc_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +	const struct of_device_id *of_id;
> > > > > +	struct device *dev = &pdev->dev;
> > > > > +	struct device_node *node = dev->of_node;
> > > > > +	struct mxs_lradc *lradc;
> > > > > +	struct mfd_cell *cells = NULL;
> > > > > +	int ret = 0;
> > > > > +	u32 ts_wires = 0;
> > > > > +
> > > > > +	lradc = devm_kzalloc(&pdev->dev, sizeof(*lradc), GFP_KERNEL);
> > > > > +	if (!lradc)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	of_id = of_match_device(mxs_lradc_dt_ids, &pdev->dev);
> > > > > +	lradc->soc = (enum mxs_lradc_id)of_id->data;
> > > > > +
> > > > > +	lradc->clk = devm_clk_get(&pdev->dev, NULL);
> > > > > +	if (IS_ERR(lradc->clk)) {
> > > > > +		dev_err(dev, "Failed to get the delay unit clock\n");
> > > > > +		return PTR_ERR(lradc->clk);
> > > > > +	}
> > > > > +
> > > > > +	ret = clk_prepare_enable(lradc->clk);
> > > > > +	if (ret) {
> > > > > +		dev_err(dev, "Failed to enable the delay unit clock\n");
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
> > > > 
> > > > Have you moved the documentation into devicetree/bindings/mfd?
> > > > 
> > > 
> > > i hope it's okay if i answer. The binding has moved to
> > > devicetree/binding/iio/adc/ [1]
> > > 
> > > Should it move completely to mfd or split too?
> > > 
> > > I'm asking myself how we keep DT ABI in the latter case.
> > > 
> > > [1] -
> > > http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
> > 
> > I haven't read into the documentation too to deeply, but it stands to
> > reason that the bindings which are now being used in MFD should be
> > documented in the MFD binding document, and the ones which are no longer
> > used in the IIO driver should be removed.
> 
> sure, that isn't a problem.
> 
> The more interesting question would be: do we need a new compatible string for
> the mfd driver?

No, I don't think that is necessary.

> In that case the ADC won't probe for the combination of old devicetree blobs and
> new kernel.


-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
