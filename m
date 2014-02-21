From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/3] mfd: fsl imx25 Touchscreen ADC driver
Date: Fri, 21 Feb 2014 10:18:44 +0100
Message-ID: <20140221091844.GB24758@pengutronix.de>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
 <1392913312-9030-2-git-send-email-mpa@pengutronix.de>
 <CAOMZO5BDyyvXs9CxJQOkuEpxZ8fqamCPB67sNhJxES+XU2XkXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5BDyyvXs9CxJQOkuEpxZ8fqamCPB67sNhJxES+XU2XkXQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

On Thu, Feb 20, 2014 at 02:17:33PM -0300, Fabio Estevam wrote:
> Hi Markus,
>=20
> On Thu, Feb 20, 2014 at 1:21 PM, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wro=
te:
> > This is the core driver for imx25 touchscreen/adc driver. The module
> > has one shared ADC and two different conversion queues which use the
> > ADC. The two queues are identical. Both can be used for general purpose
> > ADC but one is meant to be used for touchscreens.
> >
> > This driver is the core which manages the central components and
> > registers of the TSC/ADC unit. It manages the IRQs and forwards them to
> > the correct components.
> >
> > Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>=20
> That's great :-) Nice work!

Thanks :)

> > ---
> >  .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    |  46 ++++
> >  drivers/mfd/Kconfig                                |   9 +
> >  drivers/mfd/Makefile                               |   2 +
> >  drivers/mfd/fsl-imx25-tsadc.c                      | 234 +++++++++++++=
++++++++
> >  include/linux/mfd/imx25-tsadc.h                    | 138 ++++++++++++
> >  5 files changed, 429 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsa=
dc.txt
> >  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
> >  create mode 100644 include/linux/mfd/imx25-tsadc.h
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt =
b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> > new file mode 100644
> > index 0000000..a857af0e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> > @@ -0,0 +1,46 @@
> > +Freescale mx25 ADC/TSC multifunction device
> > +
> > +This device combines two general purpose conversion queues one used fo=
r general
> > +ADC and the other used for touchscreens.
> > +
> > +Required properties:
> > + - compatible: Should be "fsl,imx25-tsadc".
> > + - reg: Memory range of the device.
> > + - interrupts: Interrupt for this device as described in
> > +   interrupts/interrupts.txt
> > + - clocks: An 'ipg' clock defined as described in clocks/clock.txt
> > + - interrupt-controller: This device is an interrupt controller. It co=
ntrols
> > +   the interrupts of both conversion queues.
> > + - #interrupt-cells: Should be '<1>'.
> > + - #address-cells: Should be '<1>'.
> > + - #size-cells: Should be '<1>'.
> > + - ranges
> > +
> > +This device includes two conversion queues which can be added as subno=
des.
> > +The first queue is for the touchscreen, the second for general purpose=
 ADC.
> > +
> > +Example:
> > +       tscadc: tscadc@50030000 {
> > +               compatible =3D "fsl,imx25-tsadc";
> > +               reg =3D <0x50030000 0xc>;
> > +               interrupts =3D <46>;
> > +               clocks =3D <&clks 119>;
> > +               clock-names =3D "ipg";
> > +               interrupt-controller;
> > +               #interrupt-cells =3D <1>;
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <1>;
> > +               ranges;
> > +
> > +               tsc: tcq@50030400 {
> > +                       compatible =3D "fsl,imx25-tcq";
> > +                       reg =3D <0x50030400 0x60>;
> > +                       ...
> > +               };
> > +
> > +               adc: gcq@50030800 {
> > +                       compatible =3D "fsl,imx25-gcq";
> > +                       reg =3D <0x50030800 0x60>;
> > +                       ...
> > +               };
> > +       };
>=20
> The meaning of 'tcq' and 'gcq' acronyms are not obvious. Could they be
> written more explicitily?

I assume you mean the node names? Perhaps something like 'adcqueue'?

>=20
> Also, what does the '...' mean?
>=20
> > +static int mx25_tsadc_domain_map(struct irq_domain *d, unsigned int ir=
q,
> > +                            irq_hw_number_t hwirq)
> > +{
> > +       struct mx25_tsadc_priv *priv =3D d->host_data;
> > +
> > +       irq_set_chip_data(irq, priv);
> > +       irq_set_chip_and_handler(irq, &mx25_tsadc_irq_chip,
> > +                                handle_level_irq);
> > +
> > +#ifdef CONFIG_ARM
> > +       set_irq_flags(irq, IRQF_VALID);
> > +#else
> > +       irq_set_noprobe(irq);
> > +#endif
>=20
> Do we really need these ifdef's? Can't we just assume that CONFIG_ARM
> is always selected for this driver?

Yes right, this is not necessary here.

>=20
> > +static int mx25_tsadc_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev =3D &pdev->dev;
> > +       struct device_node *np =3D dev->of_node;
> > +       struct mx25_tsadc_priv *priv;
> > +       struct resource *iores;
> > +       int ret;
> > +       void __iomem *iomem;
> > +
> > +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       iores =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       iomem =3D devm_ioremap_resource(dev, iores);
> > +       if (IS_ERR(iomem)) {
> > +               dev_err(dev, "Failed to remap iomem\n");
> > +               return PTR_ERR(iomem);
> > +       }
> > +
> > +       priv->regs =3D regmap_init_mmio(dev, iomem, &mx25_tsadc);
> > +       if (IS_ERR(priv->regs)) {
> > +               dev_err(dev, "Failed to initialize regmap\n");
> > +               return PTR_ERR(priv->regs);
> > +       }
> > +
> > +       priv->clk =3D devm_clk_get(dev, "ipg");
> > +       if (IS_ERR(priv->clk)) {
> > +               dev_err(dev, "Failed to get ipg clock\n");
> > +               return PTR_ERR(priv->clk);
> > +       }
> > +
> > +       /* Enable clock and reset the component */
> > +       regmap_update_bits(priv->regs, MX25_TSC_TGCR, MX25_TGCR_CLK_EN,
> > +                       MX25_TGCR_CLK_EN);
> > +       regmap_update_bits(priv->regs, MX25_TSC_TGCR, MX25_TGCR_TSC_RST,
> > +                       MX25_TGCR_TSC_RST);
> > +
> > +       /* Setup powersaving mode, but enable internal reference voltag=
e */
> > +       regmap_update_bits(priv->regs, MX25_TSC_TGCR, MX25_TGCR_POWERMO=
DE_MASK,
> > +                       MX25_TGCR_POWERMODE_SAVE);
> > +       regmap_update_bits(priv->regs, MX25_TSC_TGCR, MX25_TGCR_INTREFE=
N,
> > +                       MX25_TGCR_INTREFEN);
> > +
> > +       ret =3D mx25_tsadc_setup_irq(pdev, priv);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to setup irqs\n");
> > +               return ret;
> > +       }
> > +
> > +       platform_set_drvdata(pdev, priv);
> > +
> > +       of_platform_populate(np, NULL, NULL, dev);
> > +
> > +       dev_info(dev, "i.MX25/25 Touchscreen and ADC core driver loaded=
\n");
>=20
> You could remove the double '25/25'.

Yes, fixed.

>=20
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id mx25_tsadc_ids[] =3D {
> > +       { .compatible =3D "fsl,imx25-tsadc", },
> > +       { /* Sentinel */ }
> > +};
> > +
> > +static struct platform_driver mx25_tsadc_driver =3D {
> > +       .driver         =3D {
> > +               .name   =3D "mx25-tsadc",
> > +               .owner  =3D THIS_MODULE,
> > +               .of_match_table =3D mx25_tsadc_ids,
> > +       },
> > +       .probe          =3D mx25_tsadc_probe,
> > +};
> > +module_platform_driver(mx25_tsadc_driver);
> > +
> > +MODULE_DESCRIPTION("MFD for ADC/TSC for Freescale mx25");
> > +MODULE_AUTHOR("Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
> > +MODULE_LICENSE("GPL v2");
>=20
> MODULE_ALIAS() as well?

I am not sure if this is necessary, but I added
MODULE_ALIAS("platform:mx25-tsadc")

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTBxn0AAoJEEpcgKtcEGQQfUUQAIgOh95279ZY2swQMviP+Jh0
tonvdYHBzLbLBwnfKo6k62jJWh1yjEj3QAVd7td66MWqalmt1mFfn2OCAnb1Wym0
2azxAeyt6Lz/f7ZGlThIJnws1gWASGUxR6OemEE7TdDZhCuMCEoXsKiM6fKVonRV
rQXlt+NElOEDBKenTi5cWATrpg5jxylLSdkq6KYyQzBSerGRFnG+/EjZMLXc3dM8
3A+QN2SKGzrBSA4udAjXHskJZcppLXb5xg8TJWxOV6BRVNrLmWW6PFGfvCI6W+hB
V74xoUo0Qgnsu5G7AnV9KEYrgOOOs03zfwl5pc79MMifKbe4dxYFhmc+wh8jVszn
3aLcnLVmlAXe2e/q5Ywr7NrfAeOwPOiaEe9Dv3F5osLvIkxtYkabznANgtCs3oMc
87kryoGgrFywHf7sIu2laoKgqfk8BNYxEYiNhMF5HbKF3oUJ7QKquP6tN1hU5D3T
VGRd+vjcuGs3QuxVmQsw4trmuOwlyUj+rHstHqL3Col4ZJtJggkqC5nDK1WUUTBL
6HN+/tfoeCnjAwzVrS0bLvVusPIfp52t7dxQ622NzYews4Mb5m/m3gmYwys0Yc36
8n9IMhx3vEokOs+dg4y+2bfSytqOJeWwyLpHEXEMRG+YfmMLYZoqLF5EkCCAA0eO
W8seVAKeSMic25+yvEDQ
=i6cj
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
