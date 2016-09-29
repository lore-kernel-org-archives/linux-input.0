From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v6 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Thu, 29 Sep 2016 03:38:19 +0200 (CEST)
Message-ID: <1882238802.204734.75f5f595-10ac-4107-8738-e75dfde001f1.open-xchange@email.1und1.de>
References: <cover.1474108510.git.ksenija.stanojevic@gmail.com>
 <b50209289b241995c6fd5e23c7343448857fc301.1474108510.git.ksenija.stanojevic@gmail.com>
 <20160928010533.GQ21388@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:58773 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbcI2Biy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Sep 2016 21:38:54 -0400
In-Reply-To: <20160928010533.GQ21388@dell>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: linux-input@vger.kernel.org, pmeerw@pmeerw.net, jic23@kernel.org, linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de, dmitry.torokhov@gmail.com, harald@ccbib.org, fabio.estevam@freescale.com, linux-iio@vger.kernel.org, marex@denx.de

Hi Lee,

> Lee Jones <lee.jones@linaro.org> hat am 28. September 2016 um 03:05
> geschrieben:
> 
> 
> On Sat, 17 Sep 2016, Ksenija Stanojevic wrote:
> 
> > +
> > +static int mxs_lradc_probe(struct platform_device *pdev)
> > +{
> > +	const struct of_device_id *of_id;
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *node = dev->of_node;
> > +	struct mxs_lradc *lradc;
> > +	struct mfd_cell *cells = NULL;
> > +	int ret = 0;
> > +	u32 ts_wires = 0;
> > +
> > +	lradc = devm_kzalloc(&pdev->dev, sizeof(*lradc), GFP_KERNEL);
> > +	if (!lradc)
> > +		return -ENOMEM;
> > +
> > +	of_id = of_match_device(mxs_lradc_dt_ids, &pdev->dev);
> > +	lradc->soc = (enum mxs_lradc_id)of_id->data;
> > +
> > +	lradc->clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(lradc->clk)) {
> > +		dev_err(dev, "Failed to get the delay unit clock\n");
> > +		return PTR_ERR(lradc->clk);
> > +	}
> > +
> > +	ret = clk_prepare_enable(lradc->clk);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to enable the delay unit clock\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
> 
> Have you moved the documentation into devicetree/bindings/mfd?
> 

i hope it's okay if i answer. The binding has moved to
devicetree/binding/iio/adc/ [1]

Should it move completely to mfd or split too?

I'm asking myself how we keep DT ABI in the latter case.

[1] -
http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt

> 
> -- 
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
