From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v7 3/3] iio: adc: add support for Allwinner SoCs ADC
Date: Thu,  3 Nov 2016 11:16:01 +0100
Message-ID: <20161103101601.24529-4-quentin.schulz@free-electrons.com>
References: <20161103101601.24529-1-quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161103101601.24529-1-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, dmitry.torokhov@gmail.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Allwinner SoCs all have an ADC that can also act as a touchscreen
controller and a thermal sensor. This patch adds the ADC driver which is
based on the MFD for the same SoCs ADC.

This also registers the thermal adc channel in the iio map array so
iio_hwmon could use it without modifying the Device Tree. This registers
the driver in the thermal framework.

The thermal sensor requires the IP to be in touchscreen mode to return correct
values. Therefore, if the user is continuously reading the ADC channel(s), the
thermal framework in which the thermal sensor is registered will switch the IP
in touchscreen mode to get a temperature value and requires a delay of 100ms
(because of the mode switching), then the ADC will switch back to ADC mode and
requires also a delay of 100ms. If the ADC readings are critical to user and the
SoC temperature is not, this driver is capable of not registering the thermal
sensor in the thermal framework and thus, "quicken" the ADC readings.

This driver probes on three different platform_device_id to take into
account slight differences (registers bit and temperature computation)
between Allwinner SoCs ADCs.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---

v7:
 - add Kconfig depends on !TOUCHSCREEN_SUN4I,
 - remove Kconfig selects THERMAL_OF,
 - do not register thermal sensor if CONFIG_THERMAL_OF is disabled,
 - disable irq in irq_handler rather than in read_raw,
 - add delay when switching the IP's mode or channel (delay empirically found),
 - quicken thermal sensor interrupt period,
 - add masks for channel bits,
 - fix deadlock in sun4i_gpadc_read if regmap_read/write fails,
 - move some logic from sun4i_gpadc_read to sun4i_prepare_for_irq,
 - mark last busy for runtime_pm only on success in sun4i_gpadc_read,
 - remove cached values,
 - increase wait_for_completion_timeout timeout to 1s to be sure to not miss the
 thermal interrupt,
 - add voltage scale,
 - use devm_iio_device_register,

v6:
 - remove "-mfd" from filenames and variables inside MFD driver,
 - use DEFINE_RES_IRQ_NAMED instead of setting resources manually,
 - cosmetic changes,
 - use IDs and switch over ID to get cells specific to an architecture, instead
 of using cells direclty, in of_device_id.data,
 - compute size of mfd_cells array instead of hardcoded one,

v5:
 - correct mail address,

v4:
 - rename files and variables from sunxi* to sun4i*,
 - rename defines from SUNXI_* to SUN4I_* or SUN6I_*,
 - remove TP in defines name,
 - rename SUNXI_IRQ_* to SUN4I_GPADC_IRQ_* for consistency,
 - use devm functions for regmap_add_irq_chip and mfd_add_devices,
 - remove remove functions (now empty thanks to devm functions),

v3:
 - use defines in regmap_irq instead of hard coded BITs,
 - use of_device_id data field to chose which MFD cells to add considering
   the compatible responsible of the MFD probe,
 - remove useless initializations,
 - disable all interrupts before adding them to regmap_irqchip,
 - add goto error label in probe,
 - correct wrapping in header license,
 - move defines from IIO driver to header,
 - use GENMASK to limit the size of the variable passed to a macro,
 - prefix register BIT defines with the name of the register,
 - reorder defines,

v2:
 - add license headers,
 - reorder alphabetically includes,
 - add SUNXI_GPADC_ prefixes for defines,

 drivers/iio/adc/Kconfig           |  17 ++
 drivers/iio/adc/Makefile          |   1 +
 drivers/iio/adc/sun4i-gpadc-iio.c | 605 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/sun4i-gpadc.h   |   2 +
 4 files changed, 625 insertions(+)
 create mode 100644 drivers/iio/adc/sun4i-gpadc-iio.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7edcf32..9aa3c945 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -434,6 +434,23 @@ config STX104
 	  The base port addresses for the devices may be configured via the base
 	  array module parameter.
 
+config SUN4I_GPADC
+	tristate "Support for the Allwinner SoCs GPADC"
+	depends on IIO
+	depends on MFD_SUN4I_GPADC
+	depends on !TOUCHSCREEN_SUN4I
+	help
+	  Say yes here to build support for Allwinner (A10, A13 and A31) SoCs
+	  GPADC. This ADC provides 4 channels which can be used as an ADC or as
+	  a touchscreen input and one channel for thermal sensor.
+
+	  The thermal sensor is activated by default but slows down ADC
+	  readings. You can disable CONFIG_THERMAL_OF to disable the CPU thermal
+	  sensor if you want faster ADC readings.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called sun4i-gpadc-iio.
+
 config TI_ADC081C
 	tristate "Texas Instruments ADC081C/ADC101C/ADC121C family"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 7a40c04..18ce8d6 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
 obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
 obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
 obj-$(CONFIG_STX104) += stx104.o
+obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
 obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
 obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
 obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
new file mode 100644
index 0000000..f275ccb
--- /dev/null
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -0,0 +1,605 @@
+/* ADC driver for sunxi platforms' (A10, A13 and A31) GPADC
+ *
+ * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ *
+ * The Allwinner SoCs all have an ADC that can also act as a touchscreen
+ * controller and a thermal sensor.
+ * The thermal sensor works only when the ADC acts as a touchscreen controller
+ * and is configured to throw an interrupt every fixed periods of time (let say
+ * every X seconds).
+ * One would be tempted to disable the IP on the hardware side rather than
+ * disabling interrupts to save some power but that resets the internal clock of
+ * the IP, resulting in having to wait X seconds every time we want to read the
+ * value of the thermal sensor.
+ * This is also the reason of using autosuspend in pm_runtime. If there was no
+ * autosuspend, the thermal sensor would need X seconds after every
+ * pm_runtime_get_sync to get a value from the ADC. The autosuspend allows the
+ * thermal sensor to be requested again in a certain time span before it gets
+ * shutdown for not being used.
+ */
+
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/thermal.h>
+#include <linux/delay.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/driver.h>
+#include <linux/iio/machine.h>
+#include <linux/mfd/sun4i-gpadc.h>
+
+static unsigned int sun4i_gpadc_chan_select(unsigned int chan)
+{
+	return SUN4I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
+}
+
+static unsigned int sun6i_gpadc_chan_select(unsigned int chan)
+{
+	return SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
+}
+
+struct gpadc_data {
+	int		temp_offset;
+	int		temp_scale;
+	unsigned int	tp_mode_en;
+	unsigned int	tp_adc_select;
+	unsigned int	(*adc_chan_select)(unsigned int chan);
+	unsigned int	adc_chan_mask;
+};
+
+static const struct gpadc_data sun4i_gpadc_data = {
+	.temp_offset = -1932,
+	.temp_scale = 133,
+	.tp_mode_en = SUN4I_GPADC_CTRL1_TP_MODE_EN,
+	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
+	.adc_chan_select = &sun4i_gpadc_chan_select,
+	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
+};
+
+static const struct gpadc_data sun5i_gpadc_data = {
+	.temp_offset = -1447,
+	.temp_scale = 100,
+	.tp_mode_en = SUN4I_GPADC_CTRL1_TP_MODE_EN,
+	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
+	.adc_chan_select = &sun4i_gpadc_chan_select,
+	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
+};
+
+static const struct gpadc_data sun6i_gpadc_data = {
+	.temp_offset = -1623,
+	.temp_scale = 167,
+	.tp_mode_en = SUN6I_GPADC_CTRL1_TP_MODE_EN,
+	.tp_adc_select = SUN6I_GPADC_CTRL1_TP_ADC_SELECT,
+	.adc_chan_select = &sun6i_gpadc_chan_select,
+	.adc_chan_mask = SUN6I_GPADC_CTRL1_ADC_CHAN_MASK,
+};
+
+struct sun4i_gpadc_iio {
+	struct iio_dev			*indio_dev;
+	struct completion		completion;
+	int				temp_data;
+	u32				adc_data;
+	struct regmap			*regmap;
+	unsigned int			fifo_data_irq;
+	atomic_t			ignore_fifo_data_irq;
+	unsigned int			temp_data_irq;
+	atomic_t			ignore_temp_data_irq;
+	const struct gpadc_data		*data;
+	/* prevents concurrent reads of temperature and ADC */
+	struct mutex			mutex;
+};
+
+#define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = _channel,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.datasheet_name = _name,				\
+}
+
+static struct iio_map sun4i_gpadc_hwmon_maps[] = {
+	{
+		.adc_channel_label = "temp_adc",
+		.consumer_dev_name = "iio_hwmon.0",
+	},
+	{ /* sentinel */ },
+};
+
+static const struct iio_chan_spec sun4i_gpadc_channels[] = {
+	SUN4I_GPADC_ADC_CHANNEL(0, "adc_chan0"),
+	SUN4I_GPADC_ADC_CHANNEL(1, "adc_chan1"),
+	SUN4I_GPADC_ADC_CHANNEL(2, "adc_chan2"),
+	SUN4I_GPADC_ADC_CHANNEL(3, "adc_chan3"),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.datasheet_name = "temp_adc",
+	},
+};
+
+static const struct iio_chan_spec sun4i_gpadc_channels_no_temp[] = {
+	SUN4I_GPADC_ADC_CHANNEL(0, "adc_chan0"),
+	SUN4I_GPADC_ADC_CHANNEL(1, "adc_chan1"),
+	SUN4I_GPADC_ADC_CHANNEL(2, "adc_chan2"),
+	SUN4I_GPADC_ADC_CHANNEL(3, "adc_chan3"),
+};
+
+static int sun4i_prepare_for_irq(struct iio_dev *indio_dev, int channel,
+				 unsigned int irq)
+{
+	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
+	int ret;
+	u32 reg;
+
+	pm_runtime_get_sync(indio_dev->dev.parent);
+
+	reinit_completion(&info->completion);
+
+	ret = regmap_write(info->regmap, SUN4I_GPADC_INT_FIFOC,
+			   SUN4I_GPADC_INT_FIFOC_TP_FIFO_TRIG_LEVEL(1) |
+			   SUN4I_GPADC_INT_FIFOC_TP_FIFO_FLUSH);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(info->regmap, SUN4I_GPADC_CTRL1, &reg);
+	if (ret)
+		return ret;
+
+	if (irq == info->fifo_data_irq) {
+		ret = regmap_write(info->regmap, SUN4I_GPADC_CTRL1,
+				   info->data->tp_mode_en |
+				   info->data->tp_adc_select |
+				   info->data->adc_chan_select(channel));
+		/*
+		 * When the IP changes channel, it needs a bit of time to get
+		 * correct values.
+		 */
+		if ((reg & info->data->adc_chan_mask) !=
+			 info->data->adc_chan_select(channel))
+			mdelay(10);
+
+	} else {
+		/*
+		 * The temperature sensor returns valid data only when the ADC
+		 * operates in touchscreen mode.
+		 */
+		ret = regmap_write(info->regmap, SUN4I_GPADC_CTRL1,
+				   info->data->tp_mode_en);
+	}
+
+	if (ret)
+		return ret;
+
+	/*
+	 * When the IP changes mode between ADC or touchscreen, it
+	 * needs a bit of time to get correct values.
+	 */
+	if ((reg & info->data->tp_adc_select) != info->data->tp_adc_select)
+		mdelay(100);
+
+	return 0;
+}
+
+static int sun4i_gpadc_read(struct iio_dev *indio_dev, int channel, int *val,
+			    unsigned int irq)
+{
+	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&info->mutex);
+
+	ret = sun4i_prepare_for_irq(indio_dev, channel, irq);
+	if (ret)
+		goto err;
+
+	enable_irq(irq);
+
+	/*
+	 * The temperature sensor throws an interruption periodically (currently
+	 * set at periods of ~0.6s in sun4i_gpadc_runtime_resume). A 1s delay
+	 * makes sure an interruption occurs in normal conditions. If it doesn't
+	 * occur, then there is a timeout.
+	 */
+	if (!wait_for_completion_timeout(&info->completion,
+					 msecs_to_jiffies(1000))) {
+		ret = -ETIMEDOUT;
+		goto err;
+	}
+
+	if (irq == info->fifo_data_irq)
+		*val = info->adc_data;
+	else
+		*val = info->temp_data;
+
+	ret = 0;
+	pm_runtime_mark_last_busy(indio_dev->dev.parent);
+
+err:
+	pm_runtime_put_autosuspend(indio_dev->dev.parent);
+	mutex_unlock(&info->mutex);
+
+	return ret;
+}
+
+static int sun4i_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
+				int *val)
+{
+	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
+
+	return sun4i_gpadc_read(indio_dev, channel, val, info->fifo_data_irq);
+}
+
+static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
+{
+	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
+
+	return sun4i_gpadc_read(indio_dev, 0, val, info->temp_data_irq);
+}
+
+static int sun4i_gpadc_temp_offset(struct iio_dev *indio_dev, int *val)
+{
+	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
+
+	*val = info->data->temp_offset;
+
+	return 0;
+}
+
+static int sun4i_gpadc_temp_scale(struct iio_dev *indio_dev, int *val)
+{
+	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
+
+	*val = info->data->temp_scale;
+
+	return 0;
+}
+
+static int sun4i_gpadc_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan, int *val,
+				int *val2, long mask)
+{
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_OFFSET:
+		ret = sun4i_gpadc_temp_offset(indio_dev, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type == IIO_VOLTAGE)
+			ret = sun4i_gpadc_adc_read(indio_dev, chan->channel,
+						   val);
+		else
+			ret = sun4i_gpadc_temp_read(indio_dev, val);
+
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_VOLTAGE) {
+			/* 3000mV / 4096 * raw */
+			*val = 0;
+			*val2 = 732421875;
+			return IIO_VAL_INT_PLUS_MICRO;
+		}
+
+		ret = sun4i_gpadc_temp_scale(indio_dev, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info sun4i_gpadc_iio_info = {
+	.read_raw = sun4i_gpadc_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static irqreturn_t sun4i_gpadc_temp_data_irq_handler(int irq, void *dev_id)
+{
+	struct sun4i_gpadc_iio *info = dev_id;
+
+	if (atomic_read(&info->ignore_temp_data_irq))
+		goto out;
+
+	if (!regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, &info->temp_data))
+		complete(&info->completion);
+
+out:
+	disable_irq_nosync(info->temp_data_irq);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t sun4i_gpadc_fifo_data_irq_handler(int irq, void *dev_id)
+{
+	struct sun4i_gpadc_iio *info = dev_id;
+
+	if (atomic_read(&info->ignore_fifo_data_irq))
+		goto out;
+
+	if (!regmap_read(info->regmap, SUN4I_GPADC_DATA, &info->adc_data))
+		complete(&info->completion);
+
+out:
+	disable_irq_nosync(info->fifo_data_irq);
+	return IRQ_HANDLED;
+}
+
+static int sun4i_gpadc_runtime_suspend(struct device *dev)
+{
+	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
+
+	/* Disable the ADC on IP */
+	regmap_write(info->regmap, SUN4I_GPADC_CTRL1, 0);
+	/* Disable temperature sensor on IP */
+	regmap_write(info->regmap, SUN4I_GPADC_TPR, 0);
+
+	return 0;
+}
+
+static int sun4i_gpadc_runtime_resume(struct device *dev)
+{
+	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
+
+	/* clkin = 6MHz */
+	regmap_write(info->regmap, SUN4I_GPADC_CTRL0,
+		     SUN4I_GPADC_CTRL0_ADC_CLK_DIVIDER(2) |
+		     SUN4I_GPADC_CTRL0_FS_DIV(7) |
+		     SUN4I_GPADC_CTRL0_T_ACQ(63));
+	regmap_write(info->regmap, SUN4I_GPADC_CTRL1, info->data->tp_mode_en);
+	regmap_write(info->regmap, SUN4I_GPADC_CTRL3,
+		     SUN4I_GPADC_CTRL3_FILTER_EN |
+		     SUN4I_GPADC_CTRL3_FILTER_TYPE(1));
+	/* period = SUN4I_GPADC_TPR_TEMP_PERIOD * 256 * 16 / clkin; ~0.6s */
+	regmap_write(info->regmap, SUN4I_GPADC_TPR,
+		     SUN4I_GPADC_TPR_TEMP_ENABLE |
+		     SUN4I_GPADC_TPR_TEMP_PERIOD(800));
+
+	return 0;
+}
+
+static int sun4i_gpadc_get_temp(void *data, int *temp)
+{
+	struct sun4i_gpadc_iio *info = (struct sun4i_gpadc_iio *)data;
+	int val, scale, offset;
+
+	if (sun4i_gpadc_temp_read(info->indio_dev, &val))
+		return -ETIMEDOUT;
+
+	sun4i_gpadc_temp_scale(info->indio_dev, &scale);
+	sun4i_gpadc_temp_offset(info->indio_dev, &offset);
+
+	*temp = (val + offset) * scale;
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
+	.get_temp = &sun4i_gpadc_get_temp,
+};
+
+static const struct dev_pm_ops sun4i_gpadc_pm_ops = {
+	.runtime_suspend = &sun4i_gpadc_runtime_suspend,
+	.runtime_resume = &sun4i_gpadc_runtime_resume,
+};
+
+static int sun4i_irq_init(struct platform_device *pdev, const char *name,
+			  irq_handler_t handler, const char *devname,
+			  unsigned int *irq, atomic_t *atomic)
+{
+	int ret;
+	struct sun4i_gpadc_dev *mfd_dev = dev_get_drvdata(pdev->dev.parent);
+	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(&pdev->dev));
+
+	/*
+	 * Once the interrupt is activated, the IP continuously performs
+	 * conversions thus throws interrupts. The interrupt is activated right
+	 * after being requested but we want to control when these interrupts
+	 * occur thus we disable it right after being requested. However, an
+	 * interrupt might occur between these two instructions and we have to
+	 * make sure that does not happen, by using atomic flags. We set the
+	 * flag before requesting the interrupt and unset it right after
+	 * disabling the interrupt. When an interrupt occurs between these two
+	 * instructions, reading the atomic flag will tell us to ignore the
+	 * interrupt.
+	 */
+	atomic_set(atomic, 1);
+
+	*irq = platform_get_irq_byname(pdev, name);
+	if (*irq < 0) {
+		dev_err(&pdev->dev, "no %s interrupt registered\n", name);
+		return *irq;
+	}
+
+	*irq = regmap_irq_get_virq(mfd_dev->regmap_irqc, *irq);
+	ret = devm_request_any_context_irq(&pdev->dev, *irq, handler, 0,
+					   devname, info);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not request %s interrupt: %d\n",
+			name, ret);
+		return ret;
+	}
+
+	disable_irq(*irq);
+	atomic_set(atomic, 0);
+
+	return 0;
+}
+
+static int sun4i_gpadc_probe(struct platform_device *pdev)
+{
+	struct sun4i_gpadc_iio *info;
+	struct iio_dev *indio_dev;
+	int ret;
+	struct sun4i_gpadc_dev *sun4i_gpadc_dev;
+	struct thermal_zone_device *tzd;
+
+	sun4i_gpadc_dev = dev_get_drvdata(pdev->dev.parent);
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+	platform_set_drvdata(pdev, indio_dev);
+
+	mutex_init(&info->mutex);
+	info->regmap = sun4i_gpadc_dev->regmap;
+	info->indio_dev = indio_dev;
+	init_completion(&info->completion);
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->dev.of_node = pdev->dev.of_node;
+	indio_dev->info = &sun4i_gpadc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->num_channels = ARRAY_SIZE(sun4i_gpadc_channels);
+	indio_dev->channels = sun4i_gpadc_channels;
+
+	info->data = (struct gpadc_data *)platform_get_device_id(pdev)->driver_data;
+
+	/*
+	 * Since the thermal sensor needs the IP to be in touchscreen mode and
+	 * there is no register to know if the IP has finished its transition
+	 * between the two modes, a delay is required when switching modes. This
+	 * slows down ADC readings while the latter are critical data to the
+	 * user. Disabling CONFIG_THERMAL_OF in kernel configuration allows the
+	 * user to avoid registering the thermal sensor (thus unavailable) and
+	 * does not switch between modes thus "quicken" the ADC readings.
+	 * The thermal sensor should be enabled by default since the SoC
+	 * temperature is usually more critical than ADC readings.
+	 */
+
+	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
+	/*
+	 * This driver is a child of an MFD which has a node in the DT but not
+	 * its children. Therefore, the resulting devices of this driver do not
+	 * have an of_node variable.
+	 * However, its parent (the MFD driver) has an of_node variable and
+	 * since devm_thermal_zone_of_sensor_register uses its first argument to
+	 * match the phandle defined in the node of the thermal driver with the
+	 * of_node of the device passed as first argument and the third argument
+	 * to call ops from thermal_zone_of_device_ops, the solution is to use
+	 * the parent device as first argument to match the phandle with its
+	 * of_node, and the device from this driver as third argument to return
+	 * the temperature.
+	 */
+		tzd = devm_thermal_zone_of_sensor_register(pdev->dev.parent, 0,
+							   info,
+							   &sun4i_ts_tz_ops);
+		if (IS_ERR(tzd)) {
+			dev_err(&pdev->dev,
+				"could not register thermal sensor: %ld\n",
+				PTR_ERR(tzd));
+			goto err;
+		}
+	} else {
+		indio_dev->num_channels =
+			ARRAY_SIZE(sun4i_gpadc_channels_no_temp);
+		indio_dev->channels = sun4i_gpadc_channels_no_temp;
+	}
+
+	pm_runtime_set_autosuspend_delay(&pdev->dev,
+					 SUN4I_GPADC_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
+		ret = sun4i_irq_init(pdev, "TEMP_DATA_PENDING",
+				     sun4i_gpadc_temp_data_irq_handler,
+				     "temp_data", &info->temp_data_irq,
+				     &info->ignore_temp_data_irq);
+		if (ret < 0)
+			goto err;
+	}
+
+	ret = sun4i_irq_init(pdev, "FIFO_DATA_PENDING",
+			     sun4i_gpadc_fifo_data_irq_handler, "fifo_data",
+			     &info->fifo_data_irq, &info->ignore_fifo_data_irq);
+	if (ret < 0)
+		goto err;
+
+	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
+		ret = iio_map_array_register(indio_dev, sun4i_gpadc_hwmon_maps);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"failed to register iio map array\n");
+			goto err;
+		}
+	}
+
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not register the device\n");
+		goto err_map;
+	}
+
+	return 0;
+
+err_map:
+	if (IS_ENABLED(CONFIG_THERMAL_OF))
+		iio_map_array_unregister(indio_dev);
+
+err:
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static int sun4i_gpadc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	if (IS_ENABLED(CONFIG_THERMAL_OF))
+		iio_map_array_unregister(indio_dev);
+
+	return 0;
+}
+
+static const struct platform_device_id sun4i_gpadc_id[] = {
+	{ "sun4i-a10-gpadc-iio", (kernel_ulong_t)&sun4i_gpadc_data },
+	{ "sun5i-a13-gpadc-iio", (kernel_ulong_t)&sun5i_gpadc_data },
+	{ "sun6i-a31-gpadc-iio", (kernel_ulong_t)&sun6i_gpadc_data },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver sun4i_gpadc_driver = {
+	.driver = {
+		.name = "sun4i-gpadc-iio",
+		.pm = &sun4i_gpadc_pm_ops,
+	},
+	.id_table = sun4i_gpadc_id,
+	.probe = sun4i_gpadc_probe,
+	.remove = sun4i_gpadc_remove,
+};
+
+module_platform_driver(sun4i_gpadc_driver);
+
+MODULE_DESCRIPTION("ADC driver for sunxi platforms");
+MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
index d7a29f2..509e736 100644
--- a/include/linux/mfd/sun4i-gpadc.h
+++ b/include/linux/mfd/sun4i-gpadc.h
@@ -28,6 +28,7 @@
 #define SUN4I_GPADC_CTRL1_TP_MODE_EN			BIT(4)
 #define SUN4I_GPADC_CTRL1_TP_ADC_SELECT			BIT(3)
 #define SUN4I_GPADC_CTRL1_ADC_CHAN_SELECT(x)		(GENMASK(2, 0) & (x))
+#define SUN4I_GPADC_CTRL1_ADC_CHAN_MASK			GENMASK(2, 0)
 
 /* TP_CTRL1 bits for sun6i SOCs */
 #define SUN6I_GPADC_CTRL1_TOUCH_PAN_CALI_EN		BIT(7)
@@ -35,6 +36,7 @@
 #define SUN6I_GPADC_CTRL1_TP_MODE_EN			BIT(5)
 #define SUN6I_GPADC_CTRL1_TP_ADC_SELECT			BIT(4)
 #define SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(x)		(GENMASK(3, 0) & BIT(x))
+#define SUN6I_GPADC_CTRL1_ADC_CHAN_MASK			GENMASK(3, 0)
 
 #define SUN4I_GPADC_CTRL2				0x08
 
-- 
2.9.3
