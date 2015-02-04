From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v6 5/8] iio: adc: fsl,imx25-gcq driver
Date: Wed, 04 Feb 2015 16:42:18 +0000
Message-ID: <54D24BEA.4060201@kernel.org>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de> <1422540556-14828-6-git-send-email-mpa@pengutronix.de> <54CA4419.1060207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60576 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161624AbbBDSkt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Feb 2015 13:40:49 -0500
In-Reply-To: <54CA4419.1060207@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Varka Bhadram <varkabhadram@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <festevam@gmail.com>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>
Cc: Denis Carikli <denis@eukrea.com>, =?windows-1252?Q?Eric_B=E9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On 29/01/15 14:30, Varka Bhadram wrote:
> Hi,
> 
> On Thursday 29 January 2015 07:39 PM, Markus Pargmann wrote:
>> This is a conversion queue driver for the mx25 SoC. It uses the central
>> ADC which is used by two seperate independent queues. This driver
>> prepares different conversion configurations for each possible input.
>> For a conversion it creates a conversionqueue of one item with the
>> correct configuration for the chosen channel. It then executes the queue
>> once and disables the conversion queue afterwards.
>>
>> The reference voltages are configurable through devicetree subnodes,
>> depending on the connections of the ADC inputs.
>>
>> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>> Signed-off-by: Denis Carikli <denis@eukrea.com>
>> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>> ---
>>   drivers/iio/adc/Kconfig                     |   7 +
>>   drivers/iio/adc/Makefile                    |   1 +
>>   drivers/iio/adc/fsl-imx25-gcq.c             | 361 ++++++++++++++++++++++++++++
>>   include/dt-bindings/iio/adc/fsl-imx25-gcq.h |  18 ++
>>   4 files changed, 387 insertions(+)
>>   create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
>>   create mode 100644 include/dt-bindings/iio/adc/fsl-imx25-gcq.h
>>
> (...)
> 
>> +static int mx25_gcq_probe(struct platform_device *pdev)
>> +{
>> +    struct iio_dev *indio_dev;
>> +    struct mx25_gcq_priv *priv;
>> +    struct mx25_tsadc *tsadc = dev_get_drvdata(pdev->dev.parent);
>> +    struct device *dev = &pdev->dev;
>> +    struct resource *res;
>> +    void __iomem *mem;
>> +    int ret;
>> +
>> +    indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
>> +    if (!indio_dev)
>> +        return -ENOMEM;
>> +
>> +    priv = iio_priv(indio_dev);
>> +
>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    mem = devm_ioremap_resource(dev, res);
>> +    if (!mem)
>> +        return -ENOMEM;
>> +
>> +    priv->regs = devm_regmap_init_mmio(dev, mem, &mx25_gcq_regconfig);
>> +    if (IS_ERR(priv->regs)) {
>> +        dev_err(dev, "Failed to initialize regmap\n");
>> +        return PTR_ERR(priv->regs);
>> +    }
>> +
>> +    init_completion(&priv->completed);
>> +
>> +    /* Optional external regulator */
>> +    priv->ext_vref = devm_regulator_get(&pdev->dev, "vref");
>> +    if (!IS_ERR_OR_NULL(priv->ext_vref)) {
>> +        ret = regulator_enable(priv->ext_vref);
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>> +    ret = mx25_gcq_setup_cfgs(pdev, priv);
>> +    if (ret)
>> +        return ret;
>> +
>> +    priv->clk = tsadc->clk;
>> +    ret = clk_prepare_enable(priv->clk);
>> +    if (ret) {
>> +        dev_err(dev, "Failed to enable clock\n");
>> +        return ret;
>> +    }
>> +
>> +    priv->irq = platform_get_irq(pdev, 0);
>> +    if (priv->irq <= 0) {
>> +        dev_err(dev, "Failed to get IRQ\n");
>> +        ret = priv->irq;
>> +        goto err_clk_unprepare;
>> +    }
>> +
>> +    ret = request_irq(priv->irq, mx25_gcq_irq, 0, pdev->name, priv);
> 
> Use of devm_* API
Changes the ordering wrt to the clk prepare / unprepare so don't use
devm (or change the order if appropriate! (I haven't thought about it!)

> 
>> +    if (ret) {
>> +        dev_err(dev, "Failed requesting IRQ\n");
>> +        goto err_clk_unprepare;
>> +    }
>> +
>> +    indio_dev->dev.parent = &pdev->dev;
>> +    indio_dev->channels = mx25_gcq_channels;
>> +    indio_dev->num_channels = ARRAY_SIZE(mx25_gcq_channels);
>> +    indio_dev->info = &mx25_gcq_iio_info;
>> +
>> +    ret = iio_device_register(indio_dev);
>> +    if (ret) {
>> +        dev_err(dev, "Failed to register iio device\n");
>> +        goto err_irq_free;
>> +    }
>> +
>> +    platform_set_drvdata(pdev, priv);
>> +
>> +    return 0;
>> +
>> +err_irq_free:
>> +    free_irq(priv->irq, (void *)priv);
> 
> This is not required if use devm_*
> 
>> +err_clk_unprepare:
>> +    clk_disable_unprepare(priv->clk);
>> +    return ret;
>> +}
>> +
>> +static int mx25_gcq_remove(struct platform_device *pdev)
>> +{
>> +    struct mx25_gcq_priv *priv = platform_get_drvdata(pdev);
>> +    struct iio_dev *indio_dev = iio_priv_to_dev(pdev);
>> +
>> +    iio_device_unregister(indio_dev);
>> +    free_irq(priv->irq, priv);
> 
> Dto...
> 
>>
> 

