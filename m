From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 3/3] iio: adc: fsl,imx25-gcq driver
Date: Fri, 21 Feb 2014 11:12:35 +0100
Message-ID: <20140221101235.GC24758@pengutronix.de>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
 <1392913312-9030-4-git-send-email-mpa@pengutronix.de>
 <53063F72.9070006@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37869 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497AbaBUKMn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Feb 2014 05:12:43 -0500
Content-Disposition: inline
In-Reply-To: <53063F72.9070006@metafoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@kernel.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 20, 2014 at 06:46:26PM +0100, Lars-Peter Clausen wrote:
> On 02/20/2014 05:21 PM, Markus Pargmann wrote:
> >This is a conversion queue driver for the mx25 SoC. It uses the central
> >ADC which is used by two seperate independent queues. This driver
> >prepares different conversion configurations for each possible input.
> >For a conversion it creates a conversionqueue of one item with the
> >correct configuration for the chosen channel. It then executes the queue
> >once and disables the conversion queue afterwards.
> >
> >The reference voltages are configurable through devicetree subnodes,
> >depending on the connections of the ADC inputs.
> >
> >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>=20
> Looks good mostly. Just a couple of minor code-style issues. Try to
> run checkpatch, sparse and friends on your driver before submission.
> They catch most of the stuff that needs to be fixed in this driver.

I used checkpatch and will have a look at sparse.

>=20
> [..]
> >diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> >index 2209f28..a421445 100644
> >--- a/drivers/iio/adc/Kconfig
> >+++ b/drivers/iio/adc/Kconfig
> >@@ -113,6 +113,13 @@ config EXYNOS_ADC
> >  	  of SoCs for drivers such as the touchscreen and hwmon to use to sha=
re
> >  	  this resource.
> >
> >+config MX25_ADC
> >+	tristate "Freescale MX25 ADC driver"
> >+	depends on MFD_MX25_TSADC
> >+	help
> >+	  Generic Conversion Queue driver used for general purpose ADC in the
> >+	  MX25. This driver supports single measurements using the MX25 ADC.
> >+
>=20
> alphabetical order

I changed the config option name to "FSL_MX25_ADC" to have it in
alphabetical order for the user visible menuconfig and the config
symbols.

>=20
> >  config LP8788_ADC
> >  	bool "LP8788 ADC driver"
> >  	depends on MFD_LP8788
> >diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> >index ba9a10a..63daa2c 100644
> >--- a/drivers/iio/adc/Makefile
> >+++ b/drivers/iio/adc/Makefile
> >@@ -22,3 +22,4 @@ obj-$(CONFIG_TI_ADC081C) +=3D ti-adc081c.o
> >  obj-$(CONFIG_TI_AM335X_ADC) +=3D ti_am335x_adc.o
> >  obj-$(CONFIG_TWL6030_GPADC) +=3D twl6030-gpadc.o
> >  obj-$(CONFIG_VIPERBOARD_ADC) +=3D viperboard_adc.o
> >+obj-$(CONFIG_MX25_ADC) +=3D fsl-imx25-gcq.o
>=20
> Here too

Fixed.

>=20
> [...]
>=20
> >+const struct iio_chan_spec mx25_gcq_channels[MX25_NUM_CFGS] =3D {
>=20
> static

Fixed.

>=20
> >+	MX25_IIO_CHAN(0, "xp"),
> >+	MX25_IIO_CHAN(1, "yp"),
> >+	MX25_IIO_CHAN(2, "xn"),
> >+	MX25_IIO_CHAN(3, "yn"),
> >+	MX25_IIO_CHAN(4, "wiper"),
> >+	MX25_IIO_CHAN(5, "inaux0"),
> >+	MX25_IIO_CHAN(6, "inaux1"),
> >+	MX25_IIO_CHAN(7, "inaux2"),
> >+};
> >+
>=20
> >+struct iio_info mx25_gcq_iio_info =3D {
>=20
> static const

Fixed.

>=20
> >+	.read_raw =3D mx25_gcq_read_raw,
> >+};
> >+
> >+static struct regmap_config mx25_gcq_regconfig =3D {
>=20
> const

Fixed.

>=20
> >+	.fast_io =3D true,
>=20
> You don't need to set fast_io since this is already done at the
> regmap_bus level.

Okay, I removed it.

>=20
> >+	.max_register =3D 0x5c,
> >+	.reg_bits =3D 32,
> >+	.val_bits =3D 32,
> >+	.reg_stride =3D 4,
> >+};
> >+
> >+static void mx25_gcq_iio_dev_setup(struct platform_device *pdev,
> >+		struct iio_dev *idev)
> >+{
> >+	idev->dev.parent =3D &pdev->dev;
> >+	idev->channels =3D mx25_gcq_channels;
> >+	idev->num_channels =3D ARRAY_SIZE(mx25_gcq_channels);
> >+	idev->info =3D &mx25_gcq_iio_info;
>=20
> Any reason why this needs to be in a separate function and can't be
> inlined in probe()?

No reason for that. I moved it back to probe().

>=20
> >+}
> >+
> >+static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
> >+		struct mx25_gcq_priv *priv)
> >+{
> >+	struct device_node *np =3D pdev->dev.of_node;
> >+	struct device_node *child;
> >+	struct device *dev =3D &pdev->dev;
> >+	int ret;
> >+	int i;
> >+
> >+	/* Setup all configurations registers with a default conversion
> >+	 * configuration for each input */
> >+	for (i =3D 0; i !=3D MX25_NUM_CFGS; ++i)
> >+		regmap_write(priv->regs, MX25_ADCQ_CFG(i),
> >+				MX25_ADCQ_CFG_YPLL_OFF |
> >+				MX25_ADCQ_CFG_XNUR_OFF |
> >+				MX25_ADCQ_CFG_XPUL_OFF |
> >+				MX25_ADCQ_CFG_REFP_INT |
> >+				(i << 4) |
> >+				MX25_ADCQ_CFG_REFN_NGND2);
> >+
> >+	for_each_child_of_node(np, child) {
> >+		u32 reg;
> >+		u32 refn;
> >+		u32 refp;
> >+
> >+		ret =3D of_property_read_u32(child, "reg", &reg);
> >+		if (ret) {
> >+			dev_err(dev, "Failed to get reg property\n");
> >+			return ret;
> >+		}
> >+		if (reg > MX25_NUM_CFGS) {
> >+			dev_err(dev, "reg value is greater than the number of available conf=
iguration registers\n");
> >+			return -EINVAL;
> >+		}
> >+
> >+		ret =3D of_property_read_u32(child, "fsl,adc-refn", &refn);
> >+		if (ret) {
> >+			dev_err(dev, "Failed to get fsl,adc-refn property\n");
> >+			return ret;
> >+		}
> >+
> >+		ret =3D of_property_read_u32(child, "fsl,adc-refp", &refp);
> >+		if (ret) {
> >+			dev_err(dev, "Failed to get fsl,adc-refp property\n");
> >+			return ret;
> >+		}
>=20
> Range check for refp and refn?

Range check added for both.

>=20
> >+
> >+		regmap_update_bits(priv->regs, MX25_ADCQ_CFG(reg),
> >+				MX25_ADCQ_CFG_REFP_MASK |
> >+				MX25_ADCQ_CFG_REFN_MASK,
> >+				(refp << 7) | (refn << 2));
> >+	}
> >+	regmap_update_bits(priv->regs, MX25_ADCQ_CR,
> >+			MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST,
> >+			MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST);
> >+
> >+	regmap_write(priv->regs, MX25_ADCQ_CR,
> >+			MX25_ADCQ_CR_PDMSK |
> >+			MX25_ADCQ_CR_QSM_FQS);
> >+
> >+	return 0;
> >+}
> >+
> >+static int mx25_gcq_probe(struct platform_device *pdev)
> >+{
> >+	struct iio_dev *idev;
> >+	struct mx25_gcq_priv *priv;
> >+	struct resource *res;
> >+	struct device *dev =3D &pdev->dev;
> >+	int ret;
> >+	int irq;
> >+	void __iomem *mem;
> >+
> >+	idev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> >+	if (!idev)
> >+		return -ENOMEM;
> >+
> >+	priv =3D iio_priv(idev);
> >+
> >+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >+	mem =3D devm_ioremap_resource(dev, res);
> >+	if (!mem) {
> >+		dev_err(dev, "Failed to get iomem");
>=20
> devm_ioremap_resource already prints a error message for you

Okay, I removed dev_err.
>=20
> >+		return -ENOMEM;
> >+	}
> >+
> >+	priv->regs =3D devm_regmap_init_mmio(dev, mem, &mx25_gcq_regconfig);
> >+	if (IS_ERR(priv->regs)) {
> >+		dev_err(dev, "Failed to initialize regmap\n");
> >+		return PTR_ERR(priv->regs);
> >+	}
> >+
> >+	irq =3D platform_get_irq(pdev, 0);
> >+	if (irq < 0) {
>=20
> 0 is not a valid IRQ number either

Fixed.
>=20
> >+		dev_err(dev, "Failed to get IRQ\n");
> >+		return irq;
> >+	}
> >+
> >+	ret =3D devm_request_irq(dev, irq, mx25_gcq_irq, IRQF_ONESHOT, pdev->n=
ame,
> >+			priv);
>=20
> IRQF_ONESHOT does not make much sense for non-threaded IRQs. Also it
> is probably safer to use the non managed variant of request_irq
> here.

Right, I removed the IRQF_ONESHOT flag. Why is it safer to use the non
managed request_irq?

>=20
> >+	if (ret) {
> >+		dev_err(dev, "Failed requesting IRQ\n");
>=20
> It usually makes sense to include the error number in the message.
> Same for the other error messages in probe.

The error values are returned from the probe function, so the error
number should be displayed by really_probe() in drivers/base/dd.c .

>=20
> >+		return ret;
> >+	}
> >+
> >+	ret =3D mx25_gcq_setup_cfgs(pdev, priv);
> >+	if (ret)
> >+		return ret;
> >+
> >+	mx25_gcq_iio_dev_setup(pdev, idev);
> >+
> >+	ret =3D iio_device_register(idev);
> >+	if (ret) {
> >+		dev_err(dev, "Failed to register iio device\n");
> >+		return ret;
> >+	}
> >+
> >+	init_completion(&priv->completed);
>=20
> Should be done before the interrupt handler is registered. You
> reference it in there.
>=20
> >+
> >+	priv->clk =3D mx25_tsadc_get_ipg(pdev->dev.parent);
> >+	ret =3D clk_prepare_enable(priv->clk);
>=20
> The clock should probably also be enabled before the interrupt
> handler and the IIO device are registered.

Fixed. The last two items are request_irq() and iio_device_register().

>=20
> >+	if (ret) {
> >+		dev_err(dev, "Failed to enable clock\n");
> >+		return ret;
> >+	}
> >+
> >+	platform_set_drvdata(pdev, priv);
> >+
> >+	return 0;
> >+}
> >+
> >+static int mx25_gcq_remove(struct platform_device *pdev)
> >+{
> >+	struct mx25_gcq_priv *priv =3D platform_get_drvdata(pdev);
> >+
>=20
> iio_device_unregister().

Fixed.
>=20
> >+	clk_disable_unprepare(priv->clk);
> >+
> >+	return 0;
> >+}
>=20
>=20

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTByaTAAoJEEpcgKtcEGQQhmoP/3/PlfbbgltftNAFz8CdG3BE
6bcaD78RnGM1kjuGqywyGUJXAzO/2pY4Qi17k+Srg2twfa7N1NSZiVNOEDlewH2x
pq+kUj4BtQ7xVeBrgetnn4mBfvNCJDx8W8+5rN54LA6OYDWkcDkYEthkkIO4qqh9
cwYdJOvFzf+EXzv7sblJhFiNSLB8k5y4xEObG6iOnphzgzyDHaxYHty9Z+sWJRIq
R2CWwq3g3chKOJliG4ln2G9MOWgUmcMsBbqBHRPSwcBB4KLx0p/ym+KMChN2egWu
SOb8juJCRYOOcqGCLTGIvXs8AhOmNv20/dHUBLlz+Xps1Efmci9iT5vBU8Jilq+U
9pj9elLSwnzsx0/XM0pa9HAZeDhHH+bB1Mbbt2EWqult4lX7COzNNSVOPxgRThSU
E8sMM0kEsi7hOj+Eln8xT8AWXa0BPv/rEhuSb8E0ilWt10TBFX2Ko9IHneMEL+qH
JUTbxjm4wqIFWBFYNCMk04LFkyf44vexCHPFjp5gupVxu+dYhMSFBlicPLkbg7Tv
ZyMXcpFTckEvhdgqxBrr3e7rNPo+VkIndRPzP+pNAlZZ+F0lNqyxQl5wjS1z65ZA
96w8KMHTbyIYZM1fFtElYLG1nNca599xjfwYWV787zM/O+etP2TPutOQgHUyZ/A+
cpiVzuyZQsRMH1EnmHwn
=nmJN
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
