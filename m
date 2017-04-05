From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 4/8] iio: adc: sun4i-gpadc-iio: add support
 for A33 thermal sensor
Date: Wed,  5 Apr 2017 11:06:30 +0200
Message-ID: <20170405090634.4649-5-quentin.schulz@free-electrons.com>
References: <20170405090634.4649-1-quentin.schulz@free-electrons.com>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBOPHSLDQKGQEB5LOQVY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170405090634.4649-1-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org
List-Id: linux-input@vger.kernel.org

This adds support for the Allwinner A33 thermal sensor.

Unlike the A10, A13 and A31, the Allwinner A33 only has one channel
which is dedicated to the thermal sensor. Moreover, its thermal sensor
does not generate interruptions, thus we only need to directly read the
register storing the temperature value.

The MFD used by the A10, A13 and A31, was created to avoid breaking the
DT binding, but since the nodes for the ADC weren't there for the A33,
it is not needed.

Though the A33 does not have an internal ADC, it has a thermal sensor
which shares the same registers with GPADC of the already supported SoCs
and almost the same bits, for the same purpose (thermal sensor).

The thermal sensor behaves exactly the same (except the presence of
interrupts or not) on the different SoCs.

Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---

v3:
  - switched compatible from allwinner,sun8i-a33-gpadc-iio to
  allwinner,sun8i-a33-ths to better reflect the datasheet's name,
  - fixed the non-working if (!IS_ENABLED(THERMAL_OF)) by prefixing it with
  CONFIG,

v2:
  - removed added comments in Kconfig,
  - simplified Kconfig depends on condition,
  - removed THERMAL_OF requirement for sun8i,
  - renamed sun8i_gpadc_channels to sun8i_a33_gpadc_channels,
  - renamed use_dt boolean in no_irq as it reflects better why we need it,
  - removed spurious/unneeded modifications done in v1,

 drivers/iio/adc/Kconfig           |   2 +-
 drivers/iio/adc/sun4i-gpadc-iio.c | 100 ++++++++++++++++++++++++++++++++++++--
 include/linux/mfd/sun4i-gpadc.h   |   4 ++
 3 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d0af51d..d9b6101 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -561,7 +561,7 @@ config STX104
 config SUN4I_GPADC
 	tristate "Support for the Allwinner SoCs GPADC"
 	depends on IIO
-	depends on MFD_SUN4I_GPADC
+	depends on MFD_SUN4I_GPADC || MACH_SUN8I
 	help
 	  Say yes here to build support for Allwinner (A10, A13 and A31) SoCs
 	  GPADC. This ADC provides 4 channels which can be used as an ADC or as
diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 7cb997a..74705aa 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -85,6 +85,12 @@ static const struct gpadc_data sun6i_gpadc_data = {
 	.adc_chan_mask = SUN6I_GPADC_CTRL1_ADC_CHAN_MASK,
 };
 
+static const struct gpadc_data sun8i_a33_gpadc_data = {
+	.temp_offset = -1662,
+	.temp_scale = 162,
+	.tp_mode_en = SUN8I_GPADC_CTRL1_CHOP_TEMP_EN,
+};
+
 struct sun4i_gpadc_iio {
 	struct iio_dev			*indio_dev;
 	struct completion		completion;
@@ -96,6 +102,7 @@ struct sun4i_gpadc_iio {
 	unsigned int			temp_data_irq;
 	atomic_t			ignore_temp_data_irq;
 	const struct gpadc_data		*data;
+	bool				no_irq;
 	/* prevents concurrent reads of temperature and ADC */
 	struct mutex			mutex;
 };
@@ -138,6 +145,23 @@ static const struct iio_chan_spec sun4i_gpadc_channels_no_temp[] = {
 	SUN4I_GPADC_ADC_CHANNEL(3, "adc_chan3"),
 };
 
+static const struct iio_chan_spec sun8i_a33_gpadc_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.datasheet_name = "temp_adc",
+	},
+};
+
+static const struct regmap_config sun4i_gpadc_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.fast_io = true,
+};
+
 static int sun4i_prepare_for_irq(struct iio_dev *indio_dev, int channel,
 				 unsigned int irq)
 {
@@ -247,6 +271,17 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
 
+	if (info->no_irq) {
+		pm_runtime_get_sync(indio_dev->dev.parent);
+
+		regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
+
+		pm_runtime_mark_last_busy(indio_dev->dev.parent);
+		pm_runtime_put_autosuspend(indio_dev->dev.parent);
+
+		return 0;
+	}
+
 	return sun4i_gpadc_read(indio_dev, 0, val, info->temp_data_irq);
 }
 
@@ -454,6 +489,58 @@ static int sun4i_irq_init(struct platform_device *pdev, const char *name,
 	return 0;
 }
 
+static const struct of_device_id sun4i_gpadc_of_id[] = {
+	{
+		.compatible = "allwinner,sun8i-a33-ths",
+		.data = &sun8i_a33_gpadc_data,
+	},
+	{ /* sentinel */ }
+};
+
+static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
+				struct iio_dev *indio_dev)
+{
+	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
+	const struct of_device_id *of_dev;
+	struct thermal_zone_device *tzd;
+	struct resource *mem;
+	void __iomem *base;
+	int ret;
+
+	of_dev = of_match_device(sun4i_gpadc_of_id, &pdev->dev);
+	if (!of_dev)
+		return -ENODEV;
+
+	info->no_irq = true;
+	info->data = (struct gpadc_data *)of_dev->data;
+	indio_dev->num_channels = ARRAY_SIZE(sun8i_a33_gpadc_channels);
+	indio_dev->channels = sun8i_a33_gpadc_channels;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	info->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					     &sun4i_gpadc_regmap_config);
+	if (IS_ERR(info->regmap)) {
+		ret = PTR_ERR(info->regmap);
+		dev_err(&pdev->dev, "failed to init regmap: %d\n", ret);
+		return ret;
+	}
+
+	if (!IS_ENABLED(CONFIG_THERMAL_OF))
+		return 0;
+
+	tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, info,
+						   &sun4i_ts_tz_ops);
+	if (IS_ERR(tzd))
+		dev_err(&pdev->dev, "could not register thermal sensor: %ld\n",
+			PTR_ERR(tzd));
+
+	return PTR_ERR_OR_ZERO(tzd);
+}
+
 static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
 				 struct iio_dev *indio_dev)
 {
@@ -462,6 +549,7 @@ static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
 		dev_get_drvdata(pdev->dev.parent);
 	int ret;
 
+	info->no_irq = false;
 	info->regmap = sun4i_gpadc_dev->regmap;
 
 	indio_dev->num_channels = ARRAY_SIZE(sun4i_gpadc_channels);
@@ -561,7 +649,11 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	indio_dev->info = &sun4i_gpadc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = sun4i_gpadc_probe_mfd(pdev, indio_dev);
+	if (pdev->dev.of_node)
+		ret = sun4i_gpadc_probe_dt(pdev, indio_dev);
+	else
+		ret = sun4i_gpadc_probe_mfd(pdev, indio_dev);
+
 	if (ret)
 		return ret;
 
@@ -580,7 +672,7 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	return 0;
 
 err_map:
-	if (IS_ENABLED(CONFIG_THERMAL_OF))
+	if (!info->no_irq && IS_ENABLED(CONFIG_THERMAL_OF))
 		iio_map_array_unregister(indio_dev);
 
 	pm_runtime_put(&pdev->dev);
@@ -592,10 +684,11 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 static int sun4i_gpadc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
 
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (IS_ENABLED(CONFIG_THERMAL_OF))
+	if (!info->no_irq && IS_ENABLED(CONFIG_THERMAL_OF))
 		iio_map_array_unregister(indio_dev);
 
 	return 0;
@@ -611,6 +704,7 @@ static const struct platform_device_id sun4i_gpadc_id[] = {
 static struct platform_driver sun4i_gpadc_driver = {
 	.driver = {
 		.name = "sun4i-gpadc-iio",
+		.of_match_table = sun4i_gpadc_of_id,
 		.pm = &sun4i_gpadc_pm_ops,
 	},
 	.id_table = sun4i_gpadc_id,
diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
index 509e736..139872c 100644
--- a/include/linux/mfd/sun4i-gpadc.h
+++ b/include/linux/mfd/sun4i-gpadc.h
@@ -38,6 +38,10 @@
 #define SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(x)		(GENMASK(3, 0) & BIT(x))
 #define SUN6I_GPADC_CTRL1_ADC_CHAN_MASK			GENMASK(3, 0)
 
+/* TP_CTRL1 bits for sun8i SoCs */
+#define SUN8I_GPADC_CTRL1_CHOP_TEMP_EN			BIT(8)
+#define SUN8I_GPADC_CTRL1_GPADC_CALI_EN			BIT(7)
+
 #define SUN4I_GPADC_CTRL2				0x08
 
 #define SUN4I_GPADC_CTRL2_TP_SENSITIVE_ADJUST(x)	((GENMASK(3, 0) & (x)) << 28)
-- 
2.9.3
