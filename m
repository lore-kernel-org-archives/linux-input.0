From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/5] iio/ti_am335x_adc: Allow to specify input line
Date: Wed, 29 May 2013 19:09:55 +0200
Message-ID: <1369847397-27451-5-git-send-email-bigeasy@linutronix.de>
References: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57940 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759708Ab3E2RKG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 May 2013 13:10:06 -0400
In-Reply-To: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: sameo@linux.intel.com, jic23@cam.ac.uk, dmitry.torokhov@gmail.com, balbi@ti.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The TSC part allows to specify the input lines. The IIO part assumes
that it usues always the last few, that means if IIO has adc-channels
set to 2 it will use channel 6 and 7. However it might make sense to use
only 6.
This patch changes the device property (which was introduced recently
and was never in an official release) in a way that the user can specify
which of the AIN lines should be used. In Addition to this, the name is
now AINx where x is the channel number i.e. for AIN6 we would have 6.
Prior this, it always started counting at 0 which is confusing. In
addition to this, it also checks for correct step number during reading
and does not rely on proper FIFO depth.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../bindings/input/touchscreen/ti-tsc-adc.txt      |    5 +-
 arch/arm/boot/dts/am335x-evm.dts                   |    2 +-
 drivers/iio/adc/ti_am335x_adc.c                    |   59 +++++++++++++-------
 drivers/mfd/ti_am335x_tscadc.c                     |   20 ++++++-
 4 files changed, 60 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
index 80e04e3..204c9cc 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
@@ -25,7 +25,8 @@
 			AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
 			XP  = 0, XN = 1, YP = 2, YN = 3.
 - child "adc"
-	ti,adc-channels: Number of analog inputs available for ADC
+	ti,adc-channels: List of analog inputs available for ADC.
+			 AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
 
 Example:
 	tscadc: tscadc@44e0d000 {
@@ -38,6 +39,6 @@
 		};
 
 		adc {
-			ti,adc-channels = <4>;
+			ti,adc-channels = <4 5 6 7>;
 		};
 	}
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 26fea97..0fa4c7f 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -255,6 +255,6 @@
 	};
 
 	adc {
-		ti,adc-channels = <4>;
+		ti,adc-channels = <4 5 6 7>;
 	};
 };
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 2988840..df2de4c 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -33,6 +33,8 @@
 struct tiadc_device {
 	struct ti_tscadc_dev *mfd_tscadc;
 	int channels;
+	u8 channel_line[8];
+	u8 channel_step[8];
 	char *buf;
 	struct iio_map *map;
 };
@@ -55,7 +57,7 @@ static void tiadc_writel(struct tiadc_device *adc, unsigned int reg,
 static void tiadc_step_config(struct tiadc_device *adc_dev)
 {
 	unsigned int stepconfig;
-	int i, channels = 0, steps;
+	int i, steps;
 
 	/*
 	 * There are 16 configurable steps and 8 analog input
@@ -68,16 +70,18 @@ static void tiadc_step_config(struct tiadc_device *adc_dev)
 	 */
 
 	steps = TOTAL_STEPS - adc_dev->channels;
-	channels = TOTAL_CHANNELS - adc_dev->channels;
-
 	stepconfig = STEPCONFIG_AVG_16 | STEPCONFIG_FIFO1;
 
-	for (i = steps; i < TOTAL_STEPS; i++) {
-		tiadc_writel(adc_dev, REG_STEPCONFIG(i),
-				stepconfig | STEPCONFIG_INP(channels));
-		tiadc_writel(adc_dev, REG_STEPDELAY(i),
+	for (i = 0; i < adc_dev->channels; i++) {
+		int chan;
+
+		chan = adc_dev->channel_line[i];
+		tiadc_writel(adc_dev, REG_STEPCONFIG(steps),
+				stepconfig | STEPCONFIG_INP(chan));
+		tiadc_writel(adc_dev, REG_STEPDELAY(steps),
 				STEPCONFIG_OPENDLY);
-		channels++;
+		adc_dev->channel_step[i] = steps;
+		steps++;
 	}
 	tiadc_writel(adc_dev, REG_SE, STPENB_STEPENB);
 }
@@ -101,11 +105,11 @@ static int tiadc_channel_init(struct iio_dev *indio_dev,
 	chan = chan_array;
 	for (i = 0; i < channels; i++, chan++, s += len + 1) {
 
-		len = sprintf(s, "AIN%d", i);
+		len = sprintf(s, "AIN%d", adc_dev->channel_line[i]);
 
 		chan->type = IIO_VOLTAGE;
 		chan->indexed = 1;
-		chan->channel = i;
+		chan->channel = adc_dev->channel_line[i];
 		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
 		chan->datasheet_name = s;
 		chan->scan_type.sign = 'u';
@@ -155,7 +159,8 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
 	int i;
-	unsigned int fifo1count, readx1;
+	unsigned int fifo1count, read;
+	u32 step = UINT_MAX;
 
 	/*
 	 * When the sub-system is first enabled,
@@ -168,11 +173,20 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 	 * Hence we need to flush out this data.
 	 */
 
+	for (i = 0; i < ARRAY_SIZE(adc_dev->channel_step); i++) {
+		if (chan->channel == adc_dev->channel_line[i]) {
+			step = adc_dev->channel_step[i];
+			break;
+		}
+	}
+	if (WARN_ON_ONCE(step == UINT_MAX))
+		return -EINVAL;
+
 	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
 	for (i = 0; i < fifo1count; i++) {
-		readx1 = tiadc_readl(adc_dev, REG_FIFO1);
-		if (i == chan->channel)
-			*val = readx1 & 0xfff;
+		read = tiadc_readl(adc_dev, REG_FIFO1);
+		if (read >> 16 == step)
+			*val = read & 0xfff;
 	}
 	tiadc_writel(adc_dev, REG_SE, STPENB_STEPENB);
 
@@ -189,8 +203,11 @@ static int tiadc_probe(struct platform_device *pdev)
 	struct tiadc_device	*adc_dev;
 	struct ti_tscadc_dev	*tscadc_dev = pdev->dev.platform_data;
 	struct device_node	*node = tscadc_dev->dev->of_node;
+	struct property		*prop;
+	const __be32		*cur;
 	int			err;
-	u32			val32;
+	u32			val;
+	int channels		= 0;
 
 	if (!node) {
 		dev_err(&pdev->dev, "Could not find valid DT data.\n");
@@ -212,11 +229,13 @@ static int tiadc_probe(struct platform_device *pdev)
 		err = -EINVAL;
 		goto err_free_device;
 	}
-	err = of_property_read_u32(node,
-			"ti,adc-channels", &val32);
-	if (err < 0)
-		goto err_free_device;
-	adc_dev->channels = val32;
+
+	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
+
+		adc_dev->channel_line[channels] = val;
+		channels++;
+	}
+	adc_dev->channels = channels;
 
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->name = dev_name(&pdev->dev);
diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 5e4076f..b228c41 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -66,9 +66,13 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	struct clk		*clk;
 	struct device_node	*node = pdev->dev.of_node;
 	struct mfd_cell		*cell;
+	struct property         *prop;
+	const __be32            *cur;
+	u32			val;
 	int			err, ctrl;
 	int			clk_value, clock_rate;
 	int			tsc_wires = 0, adc_channels = 0, total_channels;
+	int			readouts = 0;
 
 	if (!pdev->dev.of_node) {
 		dev_err(&pdev->dev, "Could not find valid DT data.\n");
@@ -77,16 +81,26 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
 	of_property_read_u32(node, "ti,wires", &tsc_wires);
+	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
 
 	node = of_get_child_by_name(pdev->dev.of_node, "adc");
-	of_property_read_u32(node, "ti,adc-channels", &adc_channels);
-
+	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
+		adc_channels++;
+		if (val > 7) {
+			dev_err(&pdev->dev, " PIN numbers are 0..7 (not %d)\n",
+					val);
+			return -EINVAL;
+		}
+	}
 	total_channels = tsc_wires + adc_channels;
-
 	if (total_channels > 8) {
 		dev_err(&pdev->dev, "Number of i/p channels more than 8\n");
 		return -EINVAL;
 	}
+	if (readouts * 2 + 2 + adc_channels > 16) {
+		dev_err(&pdev->dev, "Too many step configurations requested\n");
+		return -EINVAL;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-- 
1.7.10.4

