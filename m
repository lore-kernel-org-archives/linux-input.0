From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/3] mfd: fsl imx25 Touchscreen ADC driver
Date: Thu, 20 Feb 2014 14:17:33 -0300
Message-ID: <CAOMZO5BDyyvXs9CxJQOkuEpxZ8fqamCPB67sNhJxES+XU2XkXQ@mail.gmail.com>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
	<1392913312-9030-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:41206 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450AbaBTRRg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Feb 2014 12:17:36 -0500
In-Reply-To: <1392913312-9030-2-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>

Hi Markus,

On Thu, Feb 20, 2014 at 1:21 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
> This is the core driver for imx25 touchscreen/adc driver. The module
> has one shared ADC and two different conversion queues which use the
> ADC. The two queues are identical. Both can be used for general purpose
> ADC but one is meant to be used for touchscreens.
>
> This driver is the core which manages the central components and
> registers of the TSC/ADC unit. It manages the IRQs and forwards them to
> the correct components.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

That's great :-) Nice work!

> ---
>  .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    |  46 ++++
>  drivers/mfd/Kconfig                                |   9 +
>  drivers/mfd/Makefile                               |   2 +
>  drivers/mfd/fsl-imx25-tsadc.c                      | 234 +++++++++++++++++++++
>  include/linux/mfd/imx25-tsadc.h                    | 138 ++++++++++++
>  5 files changed, 429 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
>  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
>  create mode 100644 include/linux/mfd/imx25-tsadc.h
>
> diff --git a/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> new file mode 100644
> index 0000000..a857af0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> @@ -0,0 +1,46 @@
> +Freescale mx25 ADC/TSC multifunction device
> +
> +This device combines two general purpose conversion queues one used for general
> +ADC and the other used for touchscreens.
> +
> +Required properties:
> + - compatible: Should be "fsl,imx25-tsadc".
> + - reg: Memory range of the device.
> + - interrupts: Interrupt for this device as described in
> +   interrupts/interrupts.txt
> + - clocks: An 'ipg' clock defined as described in clocks/clock.txt
> + - interrupt-controller: This device is an interrupt controller. It controls
> +   the interrupts of both conversion queues.
> + - #interrupt-cells: Should be '<1>'.
> + - #address-cells: Should be '<1>'.
> + - #size-cells: Should be '<1>'.
> + - ranges
> +
> +This device includes two conversion queues which can be added as subnodes.
> +The first queue is for the touchscreen, the second for general purpose ADC.
> +
> +Example:
> +       tscadc: tscadc@50030000 {
> +               compatible = "fsl,imx25-tsadc";
> +               reg = <0x50030000 0xc>;
> +               interrupts = <46>;
> +               clocks = <&clks 119>;
> +               clock-names = "ipg";
> +               interrupt-controller;
> +               #interrupt-cells = <1>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               tsc: tcq@50030400 {
> +                       compatible = "fsl,imx25-tcq";
> +                       reg = <0x50030400 0x60>;
> +                       ...
> +               };
> +
> +               adc: gcq@50030800 {
> +                       compatible = "fsl,imx25-gcq";
> +                       reg = <0x50030800 0x60>;
> +                       ...
> +               };
> +       };

The meaning of 'tcq' and 'gcq' acronyms are not obvious. Could they be
written more explicitily?

Also, what does the '...' mean?

> +static int mx25_tsadc_domain_map(struct irq_domain *d, unsigned int irq,
> +                            irq_hw_number_t hwirq)
> +{
> +       struct mx25_tsadc_priv *priv = d->host_data;
> +
> +       irq_set_chip_data(irq, priv);
> +       irq_set_chip_and_handler(irq, &mx25_tsadc_irq_chip,
> +                                handle_level_irq);
> +
> +#ifdef CONFIG_ARM
> +       set_irq_flags(irq, IRQF_VALID);
> +#else
> +       irq_set_noprobe(irq);
> +#endif

Do we really need these ifdef's? Can't we just assume that CONFIG_ARM
is always selected for this driver?

> +static int mx25_tsadc_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct mx25_tsadc_priv *priv;
> +       struct resource *iores;
> +       int ret;
> +       void __iomem *iomem;
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       iomem = devm_ioremap_resource(dev, iores);
> +       if (IS_ERR(iomem)) {
> +               dev_err(dev, "Failed to remap iomem\n");
> +               return PTR_ERR(iomem);
> +       }
> +
> +       priv->regs = regmap_init_mmio(dev, iomem, &mx25_tsadc);
> +       if (IS_ERR(priv->regs)) {
> +               dev_err(dev, "Failed to initialize regmap\n");
> +               return PTR_ERR(priv->regs);
> +       }
> +
> +       priv->clk = devm_clk_get(dev, "ipg");
> +       if (IS_ERR(priv->clk)) {
> +               dev_err(dev, "Failed to get ipg clock\n");
> +               return PTR_ERR(priv->clk);
> +       }
> +
> +       /* Enable clock and reset the component */
> +       regmap_update_bits(priv->regs, MX25_TSC_TGCR, MX25_TGCR_CLK_EN,
> +                       MX25_TGCR_CLK_EN);
> +       regmap_update_bits(priv->regs, MX25_TSC_TGCR, MX25_TGCR_TSC_RST,
> +                       MX25_TGCR_TSC_RST);
> +
> +       /* Setup powersaving mode, but enable internal reference voltage */
> +       regmap_update_bits(priv->regs, MX25_TSC_TGCR, MX25_TGCR_POWERMODE_MASK,
> +                       MX25_TGCR_POWERMODE_SAVE);
> +       regmap_update_bits(priv->regs, MX25_TSC_TGCR, MX25_TGCR_INTREFEN,
> +                       MX25_TGCR_INTREFEN);
> +
> +       ret = mx25_tsadc_setup_irq(pdev, priv);
> +       if (ret) {
> +               dev_err(dev, "Failed to setup irqs\n");
> +               return ret;
> +       }
> +
> +       platform_set_drvdata(pdev, priv);
> +
> +       of_platform_populate(np, NULL, NULL, dev);
> +
> +       dev_info(dev, "i.MX25/25 Touchscreen and ADC core driver loaded\n");

You could remove the double '25/25'.

> +
> +       return 0;
> +}
> +
> +static const struct of_device_id mx25_tsadc_ids[] = {
> +       { .compatible = "fsl,imx25-tsadc", },
> +       { /* Sentinel */ }
> +};
> +
> +static struct platform_driver mx25_tsadc_driver = {
> +       .driver         = {
> +               .name   = "mx25-tsadc",
> +               .owner  = THIS_MODULE,
> +               .of_match_table = mx25_tsadc_ids,
> +       },
> +       .probe          = mx25_tsadc_probe,
> +};
> +module_platform_driver(mx25_tsadc_driver);
> +
> +MODULE_DESCRIPTION("MFD for ADC/TSC for Freescale mx25");
> +MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
> +MODULE_LICENSE("GPL v2");

MODULE_ALIAS() as well?
